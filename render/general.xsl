<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="text">
    <p>
      <xsl:choose>
        <xsl:when test="@class='centered'"><xsl:attribute name="style">text-align: center;</xsl:attribute></xsl:when>
      </xsl:choose>
      <xsl:copy-of select="node()"/>
    </p>
  </xsl:template>

  <xsl:template match="level[type='annotations']">
    <h3>Annotations</h3>
    <xsl:for-each select="level">
      <h4><xsl:value-of select="heading"/></h4>
      <xsl:apply-templates select="text|level"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="level[count(type) = 0]">
    <p>
        <xsl:value-of select="num"/><xsl:text> </xsl:text>
        <xsl:if test="heading"><b><xsl:value-of select="heading"/> -- </b></xsl:if>
        <xsl:if test="name((text|level)[1]) = 'text'"><xsl:copy-of select="text/node()"/></xsl:if> <!-- render first text element inline with the number and heading -->
    </p>
    <div style="margin-left: 2em">
      <!-- render remaining content indented: skip the first element if we rendered it above -->
      <xsl:apply-templates select="(text|level)[not(name()='text' and position()=1)]"/>
    </div>
  </xsl:template>

  <xsl:template match="level[count(type) &gt; 0 and not(type='annotations')]">
    <p><xsl:value-of select="type"/> <xsl:value-of select="num"/>. <xsl:value-of select="heading"/></p>
    <xsl:apply-templates select="text|level"/>
  </xsl:template>


</xsl:stylesheet>