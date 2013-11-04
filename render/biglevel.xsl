<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xi="http://www.w3.org/2001/XInclude">

  <xsl:include href="general.xsl"/>

  <xsl:output method="html" version="4.0" omit-xml-declaration="yes" encoding="utf-8" indent="yes" />

  <xsl:template match="/dc-code|/level">
<html>
	<head>
		<title>District of Columbia Code</title>
		<meta charset="utf-8" />
	</head>
    <body>
      <h1>District of Columbia Code</h1>
      <p><xsl:value-of select="dc-code/meta/recency"/></p>

      <xsl:if test="name() = 'level'" xml:space="preserve">
        <h2><xsl:value-of select="type"/> <xsl:value-of select="num"/>. <xsl:value-of select="heading"/></h2>
      </xsl:if>

      <xsl:apply-templates select="text|level|placeholder|xi:include"/>


    </body>
</html>
  </xsl:template>

  <xsl:template match="xi:include">
  	<!-- because Title 28 contains sections whose numbers contain colons in them (§ 28:2-205),
  	     we must force the relative URL to not interpret the colon as a part of a scheme. -->
    <xsl:variable name="d" select="document(concat('http:', @href), .)"/>
    <p><a href="http:{@href}" xml:space="preserve">
        <xsl:if test="$d/level">
          <xsl:if test="$d/level/type = 'Section'">§</xsl:if>
          <xsl:if test="not($d/level/type = 'Section')"><xsl:value-of select="$d/level/type"/></xsl:if>
          <xsl:value-of select="$d/level/num"/>.
          <xsl:value-of select="$d/level/heading"/>
        </xsl:if>
        <xsl:if test="$d/placeholder">
          <xsl:if test="$d/placeholder/section">
            §<xsl:value-of select="$d/placeholder/section"/>.
          </xsl:if>
          <xsl:if test="$d/placeholder/section-start">
            §§<xsl:value-of select="$d/placeholder/section-start"/>
            <xsl:if test="$d/placeholder/section-range-type = 'list'">, </xsl:if>
            <xsl:if test="$d/placeholder/section-range-type = 'range'"> to </xsl:if>
            <xsl:value-of select="$d/placeholder/section-end"/>.
          </xsl:if>
          <xsl:value-of select="$d/placeholder/heading"/>
          <xsl:if test="$d/placeholder/type">[<xsl:value-of select="$d/placeholder/type"/>]</xsl:if>
        </xsl:if>
    </a></p>
  </xsl:template>

  <xsl:template match="placeholder">
    <p>§§ <xsl:value-of select="section"/>. <xsl:value-of select="heading"/> [<xsl:value-of select="type"/></p>
    <xsl:apply-templates select="*"/>
  </xsl:template>

</xsl:stylesheet>