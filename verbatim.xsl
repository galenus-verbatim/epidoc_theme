<?xml version="1.0" encoding="UTF-8"?>
<!--


XSLT 1.0, compatible browser, PHP, Python, Java…
-->
<xsl:transform version="1.0"
    xmlns="http://www.w3.org/1999/xhtml" 
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:exslt="http://exslt.org/common"
  xmlns:saxon="http://icl.com/saxon" 
  xmlns:tei="http://www.tei-c.org/ns/1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  
  exclude-result-prefixes="tei" 
  extension-element-prefixes="exslt saxon date">
  <xsl:include href="verbatim_html.xsl"/>
  <xsl:include href="tei_header_html.xsl"/>

  <xsl:param name="proof">true</xsl:param>

  <!-- 
  https://oeuvres.github.io/teinte_theme/
  -->
  <xsl:param name="theme">
    <xsl:choose>
      <xsl:when test="true()">
        <xsl:value-of select="$xslbase"/>
      </xsl:when>
    </xsl:choose>
  </xsl:param>

  <!--  -->
  <xsl:output encoding="UTF-8" indent="yes" method="xml" omit-xml-declaration="yes"/>


  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>
          <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
        </title>
        <meta name="modified" content="{$date}"/>
        <script type="text/javascript" charset="utf-8" src="{$theme}vols.js">//</script>
        <link rel="stylesheet" type="text/css" href="https://oeuvres.github.io/teinte_theme/teinte.tree.css" />
        <link rel="stylesheet" type="text/css" href="{$theme}verbatim.css"/>
        <link rel="stylesheet" type="text/css" href="{$theme}verbatim.layout.css"/>
        <!--
        <link rel="stylesheet" type="text/css" href="{$theme}teinte.tree.css"/>
        -->
        <!-- local css links -->
        <xsl:for-each select="/tei:TEI/tei:teiHeader/tei:encodingDesc/tei:styleDefDecl[@scheme='css'][@source]">
          <link rel="stylesheet" type="text/css" href="{@source}"/>
        </xsl:for-each>
        <!-- tagsDecl ? 
        <xsl:apply-templates select="/*/tei:teiHeader/tei:encodingDesc/tei:tagsDecl"/>
        -->
      </head>
      <body>
        <div class="container" id="viewport">
          <div id="text" class="text">
            <header>
              <xsl:apply-templates select="/tei:TEI/tei:teiHeader"/>
            </header>
            <xsl:apply-templates select="/tei:TEI/tei:text"/>
          </div>
          <div id="pagimage">
              <!--
              <header id="image_header">Titre image</header>
              -->
              <img id="image"/>
          </div>
          <aside id="sidebar">
            <xsl:call-template name="side-header"/>
            <nav>
              <xsl:apply-templates select="/tei:TEI/tei:text" mode="toc"/>
            </nav>
          </aside>
        </div>
        <script type="text/javascript" charset="utf-8" src="{$theme}teinte.tree.js">//</script>
        <script type="text/javascript" charset="utf-8" src="{$theme}verbatim.js">//</script>
      </body>
    </html>
  </xsl:template>
  <!-- Metadata in toc panel, TODO -->
  <xsl:template name="side-header">
    <!--
     <header>
      <a>
        <xsl:attribute name="href">
          <xsl:for-each select="/*/tei:text">
            <xsl:call-template name="href"/>
          </xsl:for-each>
        </xsl:attribute>
        <xsl:if test="$byline != ''">
          <xsl:copy-of select="$byline"/>
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="$docdate != ''">
          <span class="docDate">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="$docdate"/>
            <xsl:text>)</xsl:text>
          </span>
        </xsl:if>
        <br/>
        <xsl:copy-of select="$doctitle"/>
      </a>
    </header>
    -->
  </xsl:template>


  <!-- Bloc de métadonnées -->
  <!--
  <xsl:template match="tei:teiHeader">
    <header id="teiHeader">
      <xsl:choose>
        <xsl:when test="not($teiheader)"/>
        <xsl:when test="../tei:text/tei:front/tei:titlePage"/>
        <xsl:otherwise>
          <xsl:apply-templates select="tei:fileDesc"/>
          <xsl:apply-templates select="tei:profileDesc/tei:abstract"/>
        </xsl:otherwise>
      </xsl:choose>
    </header>
  </xsl:template>
  -->
  
  <xsl:template match="tei:text">
    <xsl:param name="level" select="count(ancestor::tei:group)"/>
    <article>
      <xsl:attribute name="id">
        <xsl:call-template name="cts"/>
      </xsl:attribute>
      <!-- 
      <xsl:call-template name="atts"/>
      <xsl:apply-templates select="*">
        <xsl:with-param name="level" select="$level +1"/>
      </xsl:apply-templates>
      <xsl:call-template name="footnotes"/>
      -->
      <xsl:apply-templates/>
    </article>
  </xsl:template>
  
  <!--
  <xsl:template match="*" priority="-1">
    <xsl:choose>
      <xsl:when test="namespace-uri(/*) = namespace-uri()">
        <xsl:element name="{local-name()}">
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  -->


</xsl:transform>
