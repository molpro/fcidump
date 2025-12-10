<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
<tagfile doxygen_version="1.9.8">
  <compound kind="file">
    <name>LICENCE.md</name>
    <path>/__w/fcidump/fcidump/</path>
    <filename>LICENCE_8md.html</filename>
  </compound>
  <compound kind="file">
    <name>README.md</name>
    <path>/__w/fcidump/fcidump/</path>
    <filename>README_8md.html</filename>
  </compound>
  <compound kind="file">
    <name>FCIdump.cpp</name>
    <path>/__w/fcidump/fcidump/src/molpro/</path>
    <filename>FCIdump_8cpp.html</filename>
    <includes id="FCIdump_8h" name="FCIdump.h" local="yes" import="no" module="no" objc="no">molpro/FCIdump.h</includes>
    <member kind="define">
      <type>#define</type>
      <name>_GNU_SOURCE</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>a369266c24eacffb87046522897a570d5</anchor>
      <arglist></arglist>
    </member>
    <member kind="define">
      <type>#define</type>
      <name>XOUT</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>ad18bcd00eb1d496676237adc16f32ae2</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpInitialise</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>a6eb8580913673e73477f0f75ff090db4</anchor>
      <arglist>(const char *filename)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpParameterS</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>a2a9df052eb095f1891554601ef33e42c</anchor>
      <arglist>(const char *key, char *value)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpParameterI</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>a26d9db28bdd8dca84feac2a13b1a2c15</anchor>
      <arglist>(const char *key, int *values, int n)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpParameterF</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>a226ef4c6bf40067f1cedfded50eccdb1</anchor>
      <arglist>(const char *key, double *values, int n)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpRewind</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>a651c5b9391a999c04b638015dffe3dcf</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>FCIdumpNextIntegral</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>a0e5324142d94c79a7d15ba171fca62bf</anchor>
      <arglist>(int *i, int *j, int *k, int *l, double *valu)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpAddParameterS</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>a7ffd3751016d6ec67bb3ef9689fcca58</anchor>
      <arglist>(const char *key, const char *valu)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpAddParameterI</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>a567600f8d70c9f78437efa73db200156</anchor>
      <arglist>(const char *key, const int values[], int n)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpAddParameterF</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>aed7e77fc694bdcb998afcef9d4dc9dd7</anchor>
      <arglist>(const char *key, const double values[], int n)</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>FCIdumpWrite</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>a6ca3c4e687ec2a5545b69a9a79de96ae</anchor>
      <arglist>(const char *filename, int typc)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpWriteIntegral</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>a89fad2dfa1e2eb7ac885881efb6a6ffe</anchor>
      <arglist>(int i, int j, int k, int l, double valu)</arglist>
    </member>
    <member kind="variable">
      <type>molpro::FCIdump *</type>
      <name>dump</name>
      <anchorfile>FCIdump_8cpp.html</anchorfile>
      <anchor>a2643fd2f8c8bc668d6403dbaeb6dd424</anchor>
      <arglist></arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>FCIdump.h</name>
    <path>/__w/fcidump/fcidump/src/molpro/</path>
    <filename>FCIdump_8h.html</filename>
    <class kind="class">molpro::FCIdump</class>
    <namespace>molpro</namespace>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpInitialise</name>
      <anchorfile>FCIdump_8h.html</anchorfile>
      <anchor>a6eb8580913673e73477f0f75ff090db4</anchor>
      <arglist>(const char *filename)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpParameterS</name>
      <anchorfile>FCIdump_8h.html</anchorfile>
      <anchor>a2a9df052eb095f1891554601ef33e42c</anchor>
      <arglist>(const char *key, char *value)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpParameterI</name>
      <anchorfile>FCIdump_8h.html</anchorfile>
      <anchor>a26d9db28bdd8dca84feac2a13b1a2c15</anchor>
      <arglist>(const char *key, int *values, int n)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpParameterF</name>
      <anchorfile>FCIdump_8h.html</anchorfile>
      <anchor>a226ef4c6bf40067f1cedfded50eccdb1</anchor>
      <arglist>(const char *key, double *values, int n)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpRewind</name>
      <anchorfile>FCIdump_8h.html</anchorfile>
      <anchor>a651c5b9391a999c04b638015dffe3dcf</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>FCIdumpNextIntegral</name>
      <anchorfile>FCIdump_8h.html</anchorfile>
      <anchor>a0e5324142d94c79a7d15ba171fca62bf</anchor>
      <arglist>(int *i, int *j, int *k, int *l, double *valu)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpAddParameterS</name>
      <anchorfile>FCIdump_8h.html</anchorfile>
      <anchor>a7ffd3751016d6ec67bb3ef9689fcca58</anchor>
      <arglist>(const char *key, const char *valu)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpAddParameterI</name>
      <anchorfile>FCIdump_8h.html</anchorfile>
      <anchor>a567600f8d70c9f78437efa73db200156</anchor>
      <arglist>(const char *key, const int values[], int n)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpAddParameterF</name>
      <anchorfile>FCIdump_8h.html</anchorfile>
      <anchor>aed7e77fc694bdcb998afcef9d4dc9dd7</anchor>
      <arglist>(const char *key, const double values[], int n)</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>FCIdumpWrite</name>
      <anchorfile>FCIdump_8h.html</anchorfile>
      <anchor>a6ca3c4e687ec2a5545b69a9a79de96ae</anchor>
      <arglist>(const char *filename, int typc)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>FCIdumpWriteIntegral</name>
      <anchorfile>FCIdump_8h.html</anchorfile>
      <anchor>a89fad2dfa1e2eb7ac885881efb6a6ffe</anchor>
      <arglist>(int i, int j, int k, int l, double valu)</arglist>
    </member>
  </compound>
  <compound kind="file">
    <name>FCIdumpF.F90</name>
    <path>/__w/fcidump/fcidump/src/molpro/</path>
    <filename>FCIdumpF_8F90.html</filename>
    <class kind="interface">fcidumpf::fcidumpinitialisec</class>
    <class kind="interface">fcidumpf::fcidumpparameters</class>
    <class kind="interface">fcidumpf::fcidumpparameteri</class>
    <class kind="interface">fcidumpf::fcidumpparameterf</class>
    <class kind="interface">fcidumpf::fcidumpaddparameters</class>
    <class kind="interface">fcidumpf::fcidumpaddparameteri</class>
    <class kind="interface">fcidumpf::fcidumpaddparameterf</class>
    <class kind="interface">fcidumpf::fcidumprewindc</class>
    <class kind="interface">fcidumpf::fcidumpfnextintegralc</class>
    <class kind="interface">fcidumpf::fcidumpwrite</class>
    <class kind="interface">fcidumpf::fcidumpwriteintegralc</class>
    <namespace>fcidumpf</namespace>
  </compound>
  <compound kind="class">
    <name>molpro::FCIdump</name>
    <filename>classmolpro_1_1FCIdump.html</filename>
    <member kind="enumeration">
      <type></type>
      <name>fileType</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>abf54092c65166f73121d6815b21cd75b</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>FileFormatted</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>abf54092c65166f73121d6815b21cd75baa84b964ab4b7d540183eaa92f613cac8</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumeration">
      <type></type>
      <name>integralType</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>I0</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2a1f78d1ead91f4f0ac2e861c7977b4a5f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>I1a</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2ab17bae2821347ed7bf2548e7ab5fc63f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>I1b</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2a35abc8681b4e3bd76d4478c82ea3df30</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>I2aa</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2acd171fc3a2c0c3ee1385f44d590a5c78</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>I2ab</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2a60ac602322211be75ab933b76b45b4fe</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>I2bb</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2a4cc7884e4e452f3da930217fcfc41c63</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>endOfFile</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2a318ec08343cac0c225bc862025f51326</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>endOfRecord</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2a14b17af47cbb7dd9318d0523473d6213</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>FileFormatted</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>abf54092c65166f73121d6815b21cd75baa84b964ab4b7d540183eaa92f613cac8</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>I0</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2a1f78d1ead91f4f0ac2e861c7977b4a5f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>I1a</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2ab17bae2821347ed7bf2548e7ab5fc63f</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>I1b</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2a35abc8681b4e3bd76d4478c82ea3df30</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>I2aa</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2acd171fc3a2c0c3ee1385f44d590a5c78</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>I2ab</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2a60ac602322211be75ab933b76b45b4fe</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>I2bb</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2a4cc7884e4e452f3da930217fcfc41c63</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>endOfFile</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2a318ec08343cac0c225bc862025f51326</anchor>
      <arglist></arglist>
    </member>
    <member kind="enumvalue">
      <name>endOfRecord</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a14490737c137e3b2ddcbfa89702fa3b2a14b17af47cbb7dd9318d0523473d6213</anchor>
      <arglist></arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>FCIdump</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>aa2dd7262d1da87c8de6077449ce6d7aa</anchor>
      <arglist>(std::string filename=&quot;&quot;, bool old=false)</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>~FCIdump</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>aa1d780d264e94eb95759b0e41a9fb892</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type></type>
      <name>FCIdump</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a64ec7b6346444ee8e4d48fec0eef93e5</anchor>
      <arglist>(std::vector&lt; char &gt; bytestream)</arglist>
    </member>
    <member kind="function">
      <type>std::vector&lt; int &gt;</type>
      <name>parameter</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a5c709bfa1bfe9f4ae00ca235f6aa6168</anchor>
      <arglist>(const std::string &amp;key, const std::vector&lt; int &gt; &amp;def=std::vector&lt; int &gt;(1, 0)) const</arglist>
    </member>
    <member kind="function">
      <type>std::vector&lt; double &gt;</type>
      <name>parameter</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a911a09e69592b95944ef02bd37ac07d4</anchor>
      <arglist>(const std::string &amp;key, const std::vector&lt; double &gt; &amp;def) const</arglist>
    </member>
    <member kind="function">
      <type>std::vector&lt; std::string &gt;</type>
      <name>parameter</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a1021313be9208143d93b4cb9b854a12d</anchor>
      <arglist>(const std::string &amp;key, const std::vector&lt; std::string &gt; &amp;def) const</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>addParameter</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a442feb8e3721ce8d14d2abf180e7e2c8</anchor>
      <arglist>(const std::string &amp;key, const std::vector&lt; std::string &gt; &amp;values)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>addParameter</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a05a3e0b8c79716eafbb81efc11560342</anchor>
      <arglist>(const std::string &amp;key, const std::vector&lt; int &gt; &amp;values)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>addParameter</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a77ea8324639bfd744de884f29472bf25</anchor>
      <arglist>(const std::string &amp;key, const std::vector&lt; double &gt; &amp;values)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>addParameter</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a0ac2b37f7fe1932201ec4f740532481f</anchor>
      <arglist>(const std::string &amp;key, const std::string &amp;value)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>addParameter</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a633a564a96ebcf1da8070418b6340151</anchor>
      <arglist>(const std::string &amp;key, const int &amp;value)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>addParameter</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>af6c68cab0c9f1acca9a26b1d07944d11</anchor>
      <arglist>(const std::string &amp;key, const double &amp;value)</arglist>
    </member>
    <member kind="function">
      <type>std::string</type>
      <name>fileName</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>af9565f5c9bd403dc6d8e5bc7623deb5c</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>std::vector&lt; char &gt;</type>
      <name>bytestream</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a72fa9aa51c4bd9cb6e22f13fbda32075</anchor>
      <arglist>(bool integrals=true) const</arglist>
    </member>
    <member kind="function">
      <type>bool</type>
      <name>write</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a3e42f85efb808b6a2ec46de48eac8788</anchor>
      <arglist>(std::string filename=&quot;&quot;, fileType type=FileFormatted, bool integrals=true)</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>writeIntegral</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a5e06fb94d01256b5acba896f11ee9132</anchor>
      <arglist>(int i, int j, int k, int l, double value) const</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>writeIntegral</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a905d25eb340b24cd9834dba067941f64</anchor>
      <arglist>(int symi, int i, int symj, int j, int symk, int k, int syml, int l, double value) const</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>rewind</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a82416ce3307737324283b50f78041911</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>integralType</type>
      <name>nextIntegral</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a6322f7e80e7415a26d37894a2ceb144b</anchor>
      <arglist>(int &amp;i, int &amp;j, int &amp;k, int &amp;l, double &amp;value) const</arglist>
    </member>
    <member kind="function">
      <type>integralType</type>
      <name>nextIntegral</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a6b06dcf990438a778ac2afdf950e51fa</anchor>
      <arglist>(unsigned int &amp;symi, size_t &amp;i, unsigned int &amp;symj, size_t &amp;j, unsigned int &amp;symk, size_t &amp;k, unsigned int &amp;syml, size_t &amp;l, double &amp;value) const</arglist>
    </member>
    <member kind="function">
      <type>std::string</type>
      <name>data</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>acafc1329e0a2deb4ebe6423f88beba34</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>off_t</type>
      <name>orbital_symmetry</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>a57fcff96e4520ff55255f8a68ec2c91f</anchor>
      <arglist>(int orbital) const</arglist>
    </member>
    <member kind="function">
      <type>off_t</type>
      <name>orbital_offset</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>af1f14b8f27dc9a9ed42050d0db404fa7</anchor>
      <arglist>(int orbital) const</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>orbital_number</name>
      <anchorfile>classmolpro_1_1FCIdump.html</anchorfile>
      <anchor>afb8930889b7d739c05e9b11eb5a7536a</anchor>
      <arglist>(off_t symmetry, off_t offset) const</arglist>
    </member>
  </compound>
  <compound kind="interface">
    <name>fcidumpf::fcidumpaddparameterf</name>
    <filename>interfacefcidumpf_1_1fcidumpaddparameterf.html</filename>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpaddparameterf</name>
      <anchorfile>interfacefcidumpf_1_1fcidumpaddparameterf.html</anchorfile>
      <anchor>a8c713151f7fd0dd0116eb3b173eec058</anchor>
      <arglist>(key, values, n)</arglist>
    </member>
  </compound>
  <compound kind="interface">
    <name>fcidumpf::fcidumpaddparameteri</name>
    <filename>interfacefcidumpf_1_1fcidumpaddparameteri.html</filename>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpaddparameteri</name>
      <anchorfile>interfacefcidumpf_1_1fcidumpaddparameteri.html</anchorfile>
      <anchor>a05c353d5f680e7d8f5497f2505853ac8</anchor>
      <arglist>(key, values, n)</arglist>
    </member>
  </compound>
  <compound kind="interface">
    <name>fcidumpf::fcidumpaddparameters</name>
    <filename>interfacefcidumpf_1_1fcidumpaddparameters.html</filename>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpaddparameters</name>
      <anchorfile>interfacefcidumpf_1_1fcidumpaddparameters.html</anchorfile>
      <anchor>a3c06c90798162b96fb2e745f81584306</anchor>
      <arglist>(key, valu)</arglist>
    </member>
  </compound>
  <compound kind="interface">
    <name>fcidumpf::fcidumpfnextintegralc</name>
    <filename>interfacefcidumpf_1_1fcidumpfnextintegralc.html</filename>
    <member kind="function">
      <type>integer(kind=c_int) function</type>
      <name>fcidumpfnextintegralc</name>
      <anchorfile>interfacefcidumpf_1_1fcidumpfnextintegralc.html</anchorfile>
      <anchor>afe6666a7c84e2d9a534fbc43c815c688</anchor>
      <arglist>(i, j, k, l, valu)</arglist>
    </member>
  </compound>
  <compound kind="interface">
    <name>fcidumpf::fcidumpinitialisec</name>
    <filename>interfacefcidumpf_1_1fcidumpinitialisec.html</filename>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpinitialisec</name>
      <anchorfile>interfacefcidumpf_1_1fcidumpinitialisec.html</anchorfile>
      <anchor>a69cd700013d060f446c2495f1ba376e9</anchor>
      <arglist>(filename)</arglist>
    </member>
  </compound>
  <compound kind="interface">
    <name>fcidumpf::fcidumpparameterf</name>
    <filename>interfacefcidumpf_1_1fcidumpparameterf.html</filename>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpparameterf</name>
      <anchorfile>interfacefcidumpf_1_1fcidumpparameterf.html</anchorfile>
      <anchor>a9ad936739c956cfa408522988ab5637f</anchor>
      <arglist>(key, values, n)</arglist>
    </member>
  </compound>
  <compound kind="interface">
    <name>fcidumpf::fcidumpparameteri</name>
    <filename>interfacefcidumpf_1_1fcidumpparameteri.html</filename>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpparameteri</name>
      <anchorfile>interfacefcidumpf_1_1fcidumpparameteri.html</anchorfile>
      <anchor>a69d76fc9948a94a8dc3cac97e35c951a</anchor>
      <arglist>(key, values, n)</arglist>
    </member>
  </compound>
  <compound kind="interface">
    <name>fcidumpf::fcidumpparameters</name>
    <filename>interfacefcidumpf_1_1fcidumpparameters.html</filename>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpparameters</name>
      <anchorfile>interfacefcidumpf_1_1fcidumpparameters.html</anchorfile>
      <anchor>a72a5dfc0965339defa54d8e47fff6f84</anchor>
      <arglist>(key, values)</arglist>
    </member>
  </compound>
  <compound kind="interface">
    <name>fcidumpf::fcidumprewindc</name>
    <filename>interfacefcidumpf_1_1fcidumprewindc.html</filename>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumprewindc</name>
      <anchorfile>interfacefcidumpf_1_1fcidumprewindc.html</anchorfile>
      <anchor>a60ab0baf38bc7109de05f8fc7a286c8b</anchor>
      <arglist>()</arglist>
    </member>
  </compound>
  <compound kind="interface">
    <name>fcidumpf::fcidumpwrite</name>
    <filename>interfacefcidumpf_1_1fcidumpwrite.html</filename>
    <member kind="function">
      <type>integer(kind=c_int) function</type>
      <name>fcidumpwrite</name>
      <anchorfile>interfacefcidumpf_1_1fcidumpwrite.html</anchorfile>
      <anchor>a64a2def92b545791b41c52eded33f583</anchor>
      <arglist>(filename, typc)</arglist>
    </member>
  </compound>
  <compound kind="interface">
    <name>fcidumpf::fcidumpwriteintegralc</name>
    <filename>interfacefcidumpf_1_1fcidumpwriteintegralc.html</filename>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpwriteintegralc</name>
      <anchorfile>interfacefcidumpf_1_1fcidumpwriteintegralc.html</anchorfile>
      <anchor>a4110c89892307f7c743b8a9f894f0877</anchor>
      <arglist>(i, j, k, l, valu)</arglist>
    </member>
  </compound>
  <compound kind="namespace">
    <name>fcidumpf</name>
    <filename>namespacefcidumpf.html</filename>
    <class kind="interface">fcidumpf::fcidumpaddparameterf</class>
    <class kind="interface">fcidumpf::fcidumpaddparameteri</class>
    <class kind="interface">fcidumpf::fcidumpaddparameters</class>
    <class kind="interface">fcidumpf::fcidumpfnextintegralc</class>
    <class kind="interface">fcidumpf::fcidumpinitialisec</class>
    <class kind="interface">fcidumpf::fcidumpparameterf</class>
    <class kind="interface">fcidumpf::fcidumpparameteri</class>
    <class kind="interface">fcidumpf::fcidumpparameters</class>
    <class kind="interface">fcidumpf::fcidumprewindc</class>
    <class kind="interface">fcidumpf::fcidumpwrite</class>
    <class kind="interface">fcidumpf::fcidumpwriteintegralc</class>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpfinitialise</name>
      <anchorfile>namespacefcidumpf.html</anchorfile>
      <anchor>ad42588e7e3a1e20316e8238ab1df1b42</anchor>
      <arglist>(filename)</arglist>
    </member>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpfparameters</name>
      <anchorfile>namespacefcidumpf.html</anchorfile>
      <anchor>a39b4df15ef4fb5057ec0b30d868ce2b6</anchor>
      <arglist>(key, valu)</arglist>
    </member>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpfparameteri</name>
      <anchorfile>namespacefcidumpf.html</anchorfile>
      <anchor>ace07ef64e12d317c1131b1d929385ff8</anchor>
      <arglist>(key, values)</arglist>
    </member>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpfparameterf</name>
      <anchorfile>namespacefcidumpf.html</anchorfile>
      <anchor>a56cb5a9f50d6f9c445d4cad28a07cc03</anchor>
      <arglist>(key, values)</arglist>
    </member>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpfrewind</name>
      <anchorfile>namespacefcidumpf.html</anchorfile>
      <anchor>acaef90a752bd43a7cbeee437407f56d7</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>integer function</type>
      <name>fcidumpfnextintegral</name>
      <anchorfile>namespacefcidumpf.html</anchorfile>
      <anchor>a8af8363618c72b1cbec8a400d7c57bf1</anchor>
      <arglist>(i, j, k, l, valu)</arglist>
    </member>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpfaddparameters</name>
      <anchorfile>namespacefcidumpf.html</anchorfile>
      <anchor>a56686b9493c58da49773623e9ea2e777</anchor>
      <arglist>(key, valu)</arglist>
    </member>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpfaddparameteri</name>
      <anchorfile>namespacefcidumpf.html</anchorfile>
      <anchor>ae46c994cb043cba1988db63de548c32d</anchor>
      <arglist>(key, values)</arglist>
    </member>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpfaddparameterf</name>
      <anchorfile>namespacefcidumpf.html</anchorfile>
      <anchor>af97e30ca77e9c4cf2d9ef3e940697d95</anchor>
      <arglist>(key, values)</arglist>
    </member>
    <member kind="function">
      <type>logical function</type>
      <name>fcidumpfwrite</name>
      <anchorfile>namespacefcidumpf.html</anchorfile>
      <anchor>afa76474ed31bb347c7a397dc29df7c19</anchor>
      <arglist>(filename, typf)</arglist>
    </member>
    <member kind="function">
      <type>subroutine</type>
      <name>fcidumpfwriteintegral</name>
      <anchorfile>namespacefcidumpf.html</anchorfile>
      <anchor>aa453658f38bcd858455876ef7eae1f6a</anchor>
      <arglist>(i, j, k, l, valu)</arglist>
    </member>
  </compound>
  <compound kind="namespace">
    <name>molpro</name>
    <filename>namespacemolpro.html</filename>
    <class kind="class">molpro::FCIdump</class>
    <docanchor file="namespacemolpro.html">Introduction</docanchor>
  </compound>
  <compound kind="page">
    <name>md__2____w_2fcidump_2fcidump_2LICENCE</name>
    <title>LICENCE</title>
    <filename>md__2____w_2fcidump_2fcidump_2LICENCE.html</filename>
  </compound>
  <compound kind="page">
    <name>index</name>
    <title>FCIdump</title>
    <filename>index.html</filename>
    <docanchor file="index.html" title="FCIdump">md__2____w_2fcidump_2fcidump_2README</docanchor>
  </compound>
</tagfile>
