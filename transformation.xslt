<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/klinika">
    {
      "klinika": {
        "oddeleni": {
          "nazev": "<xsl:value-of select='oddeleni/nazevOddeleni'/>",
          "pacienti": [
            <xsl:for-each select="oddeleni/pacient">
              {
                "id": "<xsl:value-of select='@id'/>",
                "jmeno": "<xsl:value-of select='jmeno'/>",
                "prijmeni": "<xsl:value-of select='prijmeni'/>",
                "stav": "<xsl:value-of select='@stav'/>",
                "rizikovy": "<xsl:value-of select='@rizikovy'/>",
                "zaznamy": [
                  <xsl:for-each select="zaznamy/zaznam">
                    <xsl:sort select="datum" data-type="text" order="ascending"/>
                    {
                      "typ": "<xsl:value-of select='typ'/>",
                      "datum": "<xsl:value-of select='datum'/>",
                      "diagnoza": "<xsl:value-of select='diagnoza'/>",
                      "info": 
                      <xsl:choose>
                        <xsl:when test="typ='navsteva'">"Prvni kontakt s pacientem"</xsl:when>
                        <xsl:when test="typ='kontrola'">"Opakovana navsteva"</xsl:when>
                        <xsl:otherwise>"Jiny typ zaznamu"</xsl:otherwise>
                      </xsl:choose>,
                      "poznatka":
                      <xsl:if test="hospitalizace='true'">
                        "Pacient byl hospitalizovan"
                      </xsl:if>
                    }<xsl:if test="position() != last()">,</xsl:if>
                  </xsl:for-each>
                ]
              }<xsl:if test="position() != last()">,</xsl:if>
            </xsl:for-each>
          ]
        }
      }
    }
  </xsl:template>

</xsl:stylesheet>
