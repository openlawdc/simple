<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="general.xsl"/>

  <xsl:template match="/level">
    <html>
    <body>
      <h1>District of Columbia Code</h1>

      <h2 xml:space="preserve">§ <xsl:value-of select="num"/>. <xsl:value-of select="heading"/></h2>

      <xsl:apply-templates select="text|level"/>

    </body>
    </html>
  </xsl:template>

</xsl:stylesheet>