<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xi="http://www.w3.org/2001/XInclude">

  <xsl:include href="general.xsl"/>

  <xsl:template match="/dc-code|/level">
    <html>
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
    <xsl:variable name="d" select="document(@href, .)"/>
    <p><a href="{@href}" xml:space="preserve">
        <xsl:if test="$d/level/type = 'Section'">§</xsl:if>
        <xsl:if test="not($d/level/type = 'Section')"><xsl:value-of select="$d/level/type"/></xsl:if>
        <xsl:value-of select="$d/level/num"/>.
        <xsl:value-of select="$d/level/heading"/>
    </a></p>
  </xsl:template>

  <xsl:template match="placeholder">
    <p>§§ <xsl:value-of select="section"/>. <xsl:value-of select="heading"/> [<xsl:value-of select="type"/></p>
    <xsl:apply-templates select="*"/>
  </xsl:template>

</xsl:stylesheet>