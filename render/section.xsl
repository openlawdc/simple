<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="general.xsl"/>

  <xsl:template match="/level">
    <html>
    <body>
      <h1>District of Columbia Code</h1>

      <xsl:if test="not(type='placeholder')">
        <h2 xml:space="preserve">§ <xsl:value-of select="num"/>. <xsl:value-of select="heading"/></h2>
      </xsl:if>
      <xsl:if test="type='placeholder'">
        <h2 xml:space="preserve">
            <xsl:if test="section">
              §<xsl:value-of select="section"/>.
            </xsl:if>
            <xsl:if test="section-start">
              §§<xsl:value-of select="section-start"/>
              <xsl:if test="section-range-type = 'list'">, </xsl:if>
              <xsl:if test="section-range-type = 'range'"> to </xsl:if>
              <xsl:value-of select="section-end"/>.
            </xsl:if>
            <xsl:value-of select="heading"/>
            <xsl:if test="type">[<xsl:value-of select="reason"/>]</xsl:if>
        </h2>
      </xsl:if>

      <xsl:apply-templates select="text|level"/>

    </body>
    </html>
  </xsl:template>

</xsl:stylesheet>