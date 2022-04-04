<?xml version="1.0" encoding="UTF-8"?>

<!--
	NOTE
	
	Ci sono 3 sezioni
		1) Template di tipo "call template"
		2) Template di tipo "apply template" principale (match = "/")
		3) Altri template di tipo "apply template"
-->


<xsl:stylesheet version="2.0"
	xmlns = "http://www.w3.org/1999/xhtml"
	xmlns:html = "http://www.w3.org/1999/xhtml"
	xmlns:tei = "http://www.tei-c.org/ns/1.0"
	xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
>

<xsl:output method = "html" version = "5.0" indent = "yes" />

<!-- Lista di template-funzioni per caricare nella pagina alcuni dati -->

<!--
	Questo template-funzione serve per aumentare
	la leggibilità del codice HTML generato
-->
<xsl:template name = "a_capo">
	<xsl:text>&#10;</xsl:text>
</xsl:template>

<!-- Carica i termini tecnici -->
<xsl:template name = "termini_tecnici">
	<xsl:for-each select = "//tei:term">
		<xsl:apply-templates select = "." /><br />
	</xsl:for-each>
</xsl:template>

<!-- Carica i nomi di persona -->
<xsl:template name = "nomi_persona">
	<xsl:for-each select = "//tei:text//tei:persName">
		<xsl:apply-templates select = "." /><br />
	</xsl:for-each>
</xsl:template>

<!-- Carica parole straniere -->
<xsl:template name = "parole_straniere">
	<xsl:for-each select = "//tei:rs[@type = 'language']">
		<xsl:apply-templates select = "." /><br />
	</xsl:for-each>
</xsl:template>

<!-- Carica nomi di luoghi -->
<xsl:template name = "luoghi">
	<xsl:for-each select = "//tei:country">
		<xsl:apply-templates select = "." /><br />
	</xsl:for-each>
</xsl:template>

<xsl:template match = "/">

<html>
<head>
	<title>Prolusioni</title>
	<style>
		body
		{
			background-color : #FFDB70;
		}
	
		h2
		{
			margin-top : 100px;
		}
	
		.dx, .pagina
		{
			float : right;
		}
		
		.foglio, .pagina
		{
			width : 500px;
			heigth : auto;
		}
		
		.foglio
		{
			clear : both;
		}
		
		.pagina
		{
			background-color : white;
		}
		
		#it p
		{
			margin-top : 100px;
		}
		
		@media (max-width : 1500px)
		{
			.pagina
			{
				width : 28%;
				heigth : auto;
			}
		
			#it p
			{
				margin-top : 80px;
			}
		}
		
		@media (max-width : 1200px)
		{
			.pagina
			{
				width : 25%;
				heigth : auto;
			}
		
			#it p
			{
				margin-top : 50px;
			}
		}
	</style>
	<!-- Libreria Jquery -->
	<script src = "jquery.js"></script>
	<script>
	//Funzioni di utilità
	
		//Toglie i primi n caratteri da una stringa
		function noprimicaratteri(stringa, numero = 1)
		{
			return(stringa.substring(numero, stringa.length) );
		}
		
		//Inserisce le coordinate nel tag area
		function inserimento_coordinate(nome_paragrafo, altezza_inizio, altezza_fine)
		{
			$("#" + nome_paragrafo).attr("coords", "0," + altezza_inizio + ",500," + altezza_fine);
		}
		
		//Cambia i dati CSS in modo da far apparire una cornice
		function attiva_cornice(id_cliccabile, id_cercato)
		{
			if(id_cliccabile == id_cercato)
			{
				var relativo_paragrafo = noprimicaratteri(id_cliccabile, 3);
				var selettore_fr = "#" + relativo_paragrafo;
				var selettore_it = "#it" + relativo_paragrafo;
				
				$(selettore_fr).css("border-style", "solid");
				$(selettore_fr).css("border-color", "coral");
				
				$(selettore_it).css("border-style", "solid");
				$(selettore_it).css("border-color", "coral");
				
				
			}
		}
		
		//Toglie la cornice
		function disattiva_cornice(id_cliccabile, id_cercato)
		{
			if(id_cliccabile == id_cercato)
			{
				var relativo_paragrafo = noprimicaratteri(id_cliccabile, 3);
				var selettore_fr = "#" + relativo_paragrafo;
				var selettore_it = "#it" + relativo_paragrafo;
				
				$(selettore_fr).css("border-style", "solid");
				$(selettore_fr).css("border-color", "white");
				
				$(selettore_it).css("border-style", "solid");
				$(selettore_it).css("border-color", "white");
			}
		}
		
		//Operazioni da eseguire quando la pagina è pronta
		$(document).ready(function()
		{
			inserimento_coordinate("facp1-1", 0, 410);
			inserimento_coordinate("facp1-2", 410, 480);
			inserimento_coordinate("facp1-3", 480, 630);
			inserimento_coordinate("facp1-4", 630, 1000);
			
			inserimento_coordinate("facp2-1", 80, 235);
			inserimento_coordinate("facp2-2", 235, 500);
			inserimento_coordinate("facp2-3", 500, 1000);
	
		//Se il mouse va sopra alcuni elementi, esegue delle istruzioni
			
			//Se il mouse va sopra un elemento cliccabile, lo evidenzia
			$(".cliccabile").mouseover(function()
			{
				var id_corrente = $(this).attr("id");
				
				attiva_cornice(id_corrente, "facp1-1");
				attiva_cornice(id_corrente, "facp1-2");
				attiva_cornice(id_corrente, "facp1-3");
				attiva_cornice(id_corrente, "facp1-4");
				
				attiva_cornice(id_corrente, "facp2-1");
				attiva_cornice(id_corrente, "facp2-2");
				attiva_cornice(id_corrente, "facp2-3");
			});
			
			$(".cliccabile").mouseleave(function()
			{
				var id_corrente = $(this).attr("id");
				
				disattiva_cornice(id_corrente, "facp1-1");
				disattiva_cornice(id_corrente, "facp1-2");
				disattiva_cornice(id_corrente, "facp1-3");
				disattiva_cornice(id_corrente, "facp1-4");
				
				disattiva_cornice(id_corrente, "facp2-1");
				disattiva_cornice(id_corrente, "facp2-2");
				disattiva_cornice(id_corrente, "facp2-3");
			});
		});
		
		
		/*var id = $(this).attr("id");
				alert(id);*/
	</script>
</head>
<body>
	<h1 class="cliccabile"><xsl:apply-templates select="//tei:title" /></h1>
	<p class = "dx"><xsl:apply-templates select="//tei:respStmt" /></p>
	
	<h2>Informazioni sulla pubblicazione</h2>
	<p><xsl:apply-templates select="//tei:publicationStmt" /></p>
	
	<h2>Informazioni sul documento e sul testo</h2>
	<p><xsl:apply-templates select="//tei:sourceDesc" /></p>
	
	<h2>Visualizzazione del documento e del testo</h2>
	<p>Cliccare su un punto dell'immagine per vedere i riferimenti</p>
	
	<h3>Pagina 1</h3>
	<xsl:call-template name = "a_capo" />
	<!--
		Le coordinate non possono essere prese dal
		file xml perché il documento html usa un'altra immagine, non
		quella originale.
	-->
	<img id = "p1" class = "foglio" src = "p1.jpg" usemap = "#facp1" />
	<xsl:apply-templates select = "//tei:facsimile/tei:surface[@xml:id='facp1']" />
	
	<xsl:apply-templates select = "//tei:text[@xml:lang='it']" />
	<xsl:apply-templates select = "//tei:text[@xml:lang='fr']" />
	
	<h3>Pagina 2</h3>
	<xsl:call-template name = "a_capo" />
	<img id = "p2" class = "foglio" src = "p2.jpg" usemap = "#facp2" />
	<xsl:apply-templates select = "//tei:facsimile/tei:surface[@xml:id='facp2']" />
	
	<h2>Parole chiave</h2>
	<h3>Termini e sintagmi tecnici</h3>
	<xsl:call-template name = "termini_tecnici" />
	
	<h3>Nomi di persona trovati nel testo</h3>
	<xsl:call-template name = "nomi_persona" />
	
	<h3>Parole straniere o che indicano altre lingue</h3>
	<xsl:call-template name = "parole_straniere" />
	
	<h3>Luoghi</h3>
	<xsl:call-template name = "luoghi" />
</body>
</html>
</xsl:template>

<!-- Template per tag grandi, come text e p -->
<xsl:template match = "//tei:group/tei:text[@xml:lang='fr']">
	<div id = "fr" class = "pagina">
		<xsl:apply-templates />
	</div>
</xsl:template>

<xsl:template match = "//tei:group/tei:text[@xml:lang='it']">
	<div id = "it" class = "pagina">
		<xsl:apply-templates />
	</div>
</xsl:template>

<xsl:template match = "tei:text[@xml:lang='fr']//tei:p">
	<xsl:element name = "p">
		<xsl:attribute name = "id">
			<xsl:value-of select = "./@xml:id" />
		</xsl:attribute>
		
		<xsl:apply-templates />
	</xsl:element>
</xsl:template>

<xsl:template match = "tei:text[@xml:lang='it']//tei:p">
	<xsl:element name = "p">
		<xsl:attribute name = "id">it<xsl:value-of select = "substring(./@corresp, 2)" />
		</xsl:attribute>
		
		<xsl:apply-templates />
	</xsl:element>
</xsl:template>


<!-- Template per particolari del testo, come "a capo" e correzioni -->
	<!-- Conversione degli "a capo" -->
<xsl:template match = "//tei:lb">
	<br />
</xsl:template>



<!-- Template per tag che contengono testo da non riportare -->
	<!-- Le note non rilevanti non vengono copiate nel file HTML -->
<xsl:template match = "tei:text//tei:note">
	<!-- Vuoto (non scrive niente) -->
</xsl:template>

	<!-- Il testo cancellato non viene copiato nel file HTML -->
<xsl:template match = "//tei:del">
	<!-- Vuoto (non scrive niente) -->
</xsl:template>

	<!-- Le abbreviazioni non vengono copiate nel file HTML -->
<xsl:template match = "//tei:choice/tei:abbr">
	<!-- Vuoto (non scrive niente) -->
</xsl:template>

<!-- Template per tag relativi a grafica, geometria, superfici -->
<xsl:template match = "//tei:facsimile/tei:surface">
	<xsl:call-template name = "a_capo" />
	<!-- Creazione elemento map (a partire da surface)-->
	<xsl:element name = "map">
		<xsl:attribute name = "id">
			<xsl:value-of select = "./@xml:id" />
		</xsl:attribute>
	
		<xsl:attribute name = "name">
			<xsl:value-of select = "./@xml:id" />
		</xsl:attribute>
		
		<xsl:call-template name = "a_capo" />
		
		<!-- Creazione elementi area (a partire da zone) -->
		<xsl:apply-templates />
	</xsl:element>
<!--
	<map name = "{.[xml:id]}">
	</map>
-->
</xsl:template>

	<!-- Creazione elementi area (a partire da zone) -->
<xsl:template match = "//tei:surface/tei:zone[@xml:id != 'facp1-n' and @xml:id != 'facp2-n']">
	<xsl:element name = "area">
		<xsl:attribute name = "id">
			<xsl:value-of select = "./@xml:id" />
		</xsl:attribute>
		
		<xsl:attribute name = "class">cliccabile</xsl:attribute>
		
		<xsl:attribute name = "shape">rect</xsl:attribute>
	</xsl:element>
	<xsl:call-template name = "a_capo" />
	<xsl:call-template name = "a_capo" />
</xsl:template>

</xsl:stylesheet>






