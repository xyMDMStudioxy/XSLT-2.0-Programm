<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="utf-8"/>
<xsl:template match="/">
	<xsl:result-document href="index.html">
	<html>
	<head>
		<title>Inhaltsverzeichnis</title>
		<link rel="stylesheet" href="layout.css"/>
	</head>
	<body>
		<h1>Inhaltsverzeichnis</h1>
		<nav>
			<ul>
				<xsl:for-each select="/CDSAMMLUNG/ALBUM">
					<li><a href="cd{position()}.html"><xsl:value-of select="./TITEL/text()"/></a></li>
				</xsl:for-each>
			</ul>
		</nav>
	</body>
	</html>
	<xsl:apply-templates select="/CDSAMMLUNG"/>
	</xsl:result-document>
</xsl:template>

<xsl:template match="/CDSAMMLUNG">
	<xsl:for-each select="./ALBUM">
		<xsl:variable name="titel" select="./TITEL/text()"/>
		<xsl:variable name="interpret" select="./INTERPRET/text()"/>
		<xsl:result-document href="cd{position()}.html">
		<html>
		<head>
			<title><xsl:value-of select="./TITEL/text()"/></title>
			<link rel="stylesheet" href="layout.css"/>
		</head>
		<body>
			<h2><xsl:value-of select="./TITEL/text()"/></h2>
			<a href="index.html" id="inhalt">Inhaltsverzeichnis</a>
			<xsl:choose>
				<xsl:when test="position() = 1">
					<p><a href="cd{position()+1}.html" class="vor">vor</a></p>
				</xsl:when>
				<xsl:when test="position() = count(/CDSAMMLUNG/ALBUM/TITEL)">
					<p><a href="cd{position()-1}.html" class="zurueck">zurück</a></p>
				</xsl:when>
				<xsl:otherwise>
					<p><a href="cd{position()+1}.html" class="vor">vor</a></p>
					<p><a href="cd{position()-1}.html" class="zurueck">zurück</a></p>
				</xsl:otherwise>
			</xsl:choose>
			<div id="interpret">
				<p>Weitere CD's des Interpreten:</p>
				<ul>
					<xsl:for-each select="/CDSAMMLUNG/ALBUM">
					<xsl:if test="./INTERPRET=$interpret and TITEL!=$titel">
						<li><a href="cd{position()}.html"><xsl:value-of select="./TITEL/text()"/></a></li>
					</xsl:if>
					</xsl:for-each>
				</ul>
			</div>

			<div id="tracks">
				<p>Tracks:</p>
				<ul>
					<xsl:if test="/CDSAMMLUNG/ALBUM/TITEL=$titel">
						<xsl:for-each select="./TRACKS/TRACK">
							<li><xsl:value-of select="text()"/>
							<xsl:variable name="track" select="text()"/>
							<xsl:for-each select="/CDSAMMLUNG/ALBUM">
								<xsl:if test="TRACKS/TRACK=$track and TITEL!=$titel">
								--> <a href="cd{position()}.html"><xsl:value-of select="./TITEL/text()"/></a>
								</xsl:if>
							</xsl:for-each>
							</li>
						</xsl:for-each>
					</xsl:if>
				</ul>
			</div>
		</body>
		</html>
		</xsl:result-document>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>