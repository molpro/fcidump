#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include <type_traits>
#include <vector>
#include <cstdio>

#include "molpro/FCIdump.h"

static double testvalue(int i, int j, int k, int l) {
  auto ij = std::max(i, j) * (std::max(i, j) + 1) / 2 + std::min(i, j);
  auto kl = std::max(k, l) * (std::max(k, l) + 1) / 2 + std::min(k, l);
  return (ij + kl) * 1000 + std::abs(ij - kl) + 1;
}

TEST(testFCIdump, basic) {
  using ::testing::Pointwise;
  using ::testing::Eq;
  using ::testing::DoubleNear;
  std::string dumpname("testFCIdump.fcidump");
  std::vector<int> symmetries{1, 1, 2, 1, 2};
  std::vector<std::vector<int> > integrals;
  integrals.push_back({1, 1, 3, 3});
  integrals.push_back({2, 1, 5, 3});
  integrals.push_back({3, 1, 5, 1});
  integrals.push_back({1, 3, 5, 1});
  integrals.push_back({1, 3, 1, 5});
  integrals.push_back({1, 1, 0, 0});
  {
    remove(dumpname.c_str());
    FCIdump dump(dumpname);
    dump.addParameter("NORB", int(symmetries.size()));
    dump.addParameter("NELEC", 2);
    dump.addParameter("ISYM", 1);
    dump.addParameter("ORBSYM", symmetries);
    dump.write();
    for (const auto& labels : integrals)
      dump.writeIntegral(labels[0],
                         labels[1],
                         labels[2],
                         labels[3],
                         testvalue(labels[0], labels[1], labels[2], labels[3]));
  }

  {
    FCIdump dump(dumpname, true);
    dump.rewind();
    for (auto sym = 0; sym < 8; sym++) {
      size_t off = 0;
      for (auto i = 1; i < symmetries.size() + 1; i++)
        if (dump.orbital_symmetry(i) == sym)
          ASSERT_EQ(dump.orbital_offset(i), off++);
    }
  }

  {
    FCIdump dump(dumpname, true);
    ASSERT_THAT(dump.parameter("ORBSYM"), Pointwise(Eq(), symmetries));
    {
      double value;
      int i, j, k, l;
      dump.rewind();
      for (const auto& labels : integrals) {
        auto type = dump.nextIntegral(i, j, k, l, value);
        ASSERT_NE(type, FCIdump::endOfFile);
        ASSERT_THAT(value, DoubleNear(testvalue(labels[0], labels[1], labels[2], labels[3]), 1e-12));
        ASSERT_THAT(std::vector<int>({i, j, k, l}), Pointwise(Eq(), labels));
      }
      auto type = dump.nextIntegral(i, j, k, l, value);
      ASSERT_EQ(type, FCIdump::endOfFile);
    }

    {
      double value;
      off_t is, js, ks, ls, io, jo, ko, lo;
      unsigned int isu, jsu, ksu, lsu;
      size_t ios, jos, kos, los;
      dump.rewind();
      for (const auto& labels : integrals) {
        auto type = dump.nextIntegral(isu, ios, jsu, jos, ksu, kos, lsu, los, value);
        is=isu; js=jsu; ks=ksu; ls=lsu;
        io=ios; jo=jos; ko=kos; lo=los;
        ASSERT_NE(type, FCIdump::endOfFile);
        ASSERT_THAT(value, DoubleNear(testvalue(labels[0], labels[1], labels[2], labels[3]), 1e-12));
        if (is < 8 && ks < 8)
          ASSERT_THAT(std::vector<off_t>({is, io, js, jo, ks, ko, ls, lo}),
                      Pointwise(Eq(), std::vector<off_t>{
                          dump.orbital_symmetry(labels[0]), dump.orbital_offset(labels[0]),
                          dump.orbital_symmetry(labels[1]), dump.orbital_offset(labels[1]),
                          dump.orbital_symmetry(labels[2]), dump.orbital_offset(labels[2]),
                          dump.orbital_symmetry(labels[3]), dump.orbital_offset(labels[3])
                      }));
        else if (is < 8)
          ASSERT_THAT(std::vector<off_t>({is, io, js, jo}),
                      Pointwise(Eq(), std::vector<off_t>{
                          dump.orbital_symmetry(labels[0]), dump.orbital_offset(labels[0]),
                          dump.orbital_symmetry(labels[1]), dump.orbital_offset(labels[1])
                      }));
      }
      auto type = dump.nextIntegral(isu, ios, jsu, jos, ksu, kos, lsu, los, value);
      ASSERT_EQ(type, FCIdump::endOfFile);
    }
  }
}