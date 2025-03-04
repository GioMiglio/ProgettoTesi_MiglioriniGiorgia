<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                  xmlns:tei="http://www.tei-c.org/ns/1.0"               
                  xmlns:mei="http://www.music-encoding.org/ns/mei"
                  version="1.0">
  <xsl:output method="html" encoding="UTF-8"/>

    <!--variabili per la creazione di grafiche vettoriali (SVG)-->
    <xsl:output indent="yes"/>
    <xsl:variable name="lineXStart" select="30"/>
    <xsl:variable name="lineYStart" select="40"/>
    <xsl:variable name="lineLength" select="count(.//mei:note | .//mei:beam/mei:note)*25"/>
    <xsl:variable name="lineBuffer" select="10"/>
    <xsl:variable name="noteXStart" select="$lineXStart + 50"/>
    <xsl:variable name="noteXRadius" select="6"/>
    <xsl:variable name="sharpXOffset" select="$noteXRadius * 4.2"/>
    <xsl:variable name="flatXOffset" select="$noteXRadius * 2.7"/>
    <xsl:variable name="noteYRadius" select="5"/>
    <xsl:variable name="sharpYOffset" select="$noteYRadius * 2.3"/>
    <xsl:variable name="flatYOffset" select="$noteYRadius * 2.9"/>
    <xsl:variable name="itemBuffer" select="37"/>
    <xsl:variable name="ledgerBuffer" select="5"/>
    <xsl:variable name="middleCYPosition" select="$lineYStart+50"/>
    <xsl:variable name="startingValue" select="80"/>

<!--Mappa i valori verticali e orizzontali delle note sulla base dell'id -->
    <!--NOTE tramite id/ref-->
     <xsl:key name="noteById" match="tei:note" use="@xml:id" />
    <!--PERSONE tramite id/ref-->
    <xsl:key name="persName-by-id" match="tei:persName" use="@xml:id" />
    <!--ORGANIZZAZIONI tramite id/ref-->
     <xsl:key name="org-by-id" match="tei:org" use="@xml:id" />

    <xsl:key name="xPositionKey" match="mei:note" use="@xml:id"/>
   <xsl:key name="yPositionKey" match="mei:note" use="@xml:id"/>
    

  
    
<!--dichiarazione dei namespace TEI e MEI, i cui moduli sono stati impiegati per la marcatura dei testi-->

      <xsl:template match="/">
         <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                 <link rel="stylesheet" type="text/css" href="stile.css" />
                 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                 <script type="text/javascript" src="ProgettoTesi_MG.js"></script>
                 
                <title>La fabbrica illuminata: per un'analisi e codifica del testo</title>

            </head>

            <body>
        
                <div id="frontpage">
                    <img src="CarmiLisetta_Italsider4.jpg" alt="Carmi Lisetta dentro l'Italsider"/>
                    <h2>La fabbrica illuminata</h2>
                    <div id="nav">
                     <h3>LA FABBRICA ILLUMINATA</h3>
                   <ul>
                     <li><a href="#ilprogetto">Il progetto</a></li>
                     <li><a href="#sez4">Le fonti</a></li>
                     <li><a href="#lettera1">Luigi Nono - Lettera agli operai dell'Italsider</a></li>
                     <li><a href="#lettera2">Giuliano Scabia - Chi è la folle?</a></li>
                     <li><a href="#imangiatoridinebbia">Giuliano Scabia - I mangiatori di Nebbia</a></li>
                     <li><a href="#tavole_fonetiche">Dal Diario italiano: Coro - I vivi e i morti del Vajont</a></li>
                     <li><a href="#fb_provvisorie">La fabbrica illuminata (stesure I-V)</a></li>
                     <li><a href="#fb_definitiva">La fabbrica illuminata (stesura definitiva)</a></li>
                   </ul>
                </div>
                </div>


               <div id="ilprogetto">
                  <div id="MainTit">
                    <h2>
                        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='main']"/>
                    </h2>
                    <h3>                        
                       <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='sub']"/>
                    </h3>
                    <p>
                        <b>Realizzato da <xsl:value-of  select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:principal/tei:persname"/> grazie al supporto di: </b>
                        <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:sponsor"/>
                    </p>

                    <p>                
                        <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt"/>    
                    </p>
                    <p>
                      <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>    
                    </p>
                    <img id="i1" src="logofondazione.png" alt="Unipi"/>
                    <img id="i2" src="Logo-UNIIPI-nero.png" alt="Unipi"/>
                </div>

                <div id="sez1">
                  <div id="text_sez1">
                     <p>
                      <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:encodingDesc/tei:projectDesc"/>
                     </p>
                   </div>    
                   <img src="CarmiLisetta_Italsider2.png" alt="Lisetta Carmi visita L'Italsider"/>
                </div>

                <div id="sez2">
                   <img src="CarmiLisetta_Italsider1.png" alt="Lisetta Carmi visita L'Italsider"/>
                    <div id="text_sez2">
                     <p>
                      <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:encodingDesc/tei:samplingDecl"/>
                     </p>
                   </div>                  
                 </div>

                 <div id="sez3">
                 <div id="text_sez3">

                     <p>
                      <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:encodingDesc/tei:editorialDecl/tei:correction"/>
                     </p>
             
                      <p>
                      <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:encodingDesc/tei:editorialDecl/tei:segmentation"/>
                     </p>
                     <h2><b>Interpretazione e scelte di codifica</b></h2>
                    </div> 
                    
                    <div id="text_sez3">
                       <p>
                      <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:encodingDesc/tei:editorialDecl/tei:interpretation"/>
                     </p>
                   </div>  
                    <div id="all_img">
                          <img src="GiulianoScabia.jpg" alt="GS"/>
                            <img src="GiulianoScabia2.jpg" alt="GS"/>
                            <img src="GiulianoScabia3.jpg" alt="GS"/>
                    </div> 
                 </div>
                  <div id="sez4">
                    <div id="text_sez4">
                    <h2><b>Le fonti</b></h2>
                      
                        <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listBibl"/>
                    
                    </div>
                  </div> 
               </div>
                 

                <div id="all_text">

                <div id="bottoni">
                    <h2>Fenomeni Notevoli</h2>
                  
                   <p>Le lettere</p>
                        <button id="persone" class="red">Persone</button>
                        <button id="comunità" class="yellow">Comunità</button>
                        <button id="Luoghi_countries" class="DeepPink">Paesi e Regioni</button>
                        <button id="Luoghi_settlements" class="Pink">Città e Villaggi</button>
                        <button id="ref_bibl" class="orange">Referenze bibliografiche</button>
                        <button id="org" class="Maroon">Organizzazioni</button>
                        <button id="Date" class="LawnGreen">Date</button>
                        <button id="sic" class="DarkGreen">Errori e correzioni</button>                       
                        <button id="destinatario" class="DarkSalmon">Chi è il destinatario?</button>
                        <button id="quotes" class="Salmon">Quotes</button> 
                        <button id="condizionidilavoro" class="Blue">Condizione operaia</button>     
                        <button id="socioeconomic" class="cyan">Condizione socio-economica</button>
                        <button id="psy" class="Olive">Tecnicismi psicologici</button>   
                        <button id="eventistorici" class="DarkOrange">Eventi Storici</button>      
                        <button id="epithet_rolenames" class="DarkCyan">Epiteti e Apposizioni</button>
                        <button id="manoscritte" class="Indigo">Correzioni manoscritte</button>
                        <button id="abbr" class="Teal">Abbreviazioni</button>
                        <button id="uncl" class="Tomato">Interpretazione incerta</button>             
                        <p>Testi poetici</p>
                        <button id="not_mus" class="Blue">Frammenti musicali</button> 
                        <button id="tecnicismi" class="brown"><i>La stralingua</i></button>
                        <button id="umano" class="red">L'uomo</button>
                        <button id="fabbrica" class="yellow">La fabbrica</button>
                        <button id="acuto" class="DeepPink">Direttive: <i>Cantus firmus</i> / Sincronia sonora</button>
                        <button id="pausa" class="DeepPink">Direttive: Pause</button>
                        <button id="scenografia" class="orange">Direttive: Scenografia</button>
                        <button id="battute" class="Maroon">Direttive: Battute</button>
                        <button id="quotes2" class="Salmon">Materiale tratto dall'Inchiesta</button>
                        <button id="solo" class="Olive">Direttive: Solista</button>
                        <button id="spazi" class="Teal">Direttive: Pieni sonori</button> 
                        <button id="quotes3" class="Salmon">Versi di Cesare Pavese</button> 
                        <button id="iniz" class="Maroon">Attacco</button>
                        <button id="tenut" class="Maroon">Tenuta melodica</button>
                        <button id="ferm" class="Maroon">Fermata</button>
                </div>


                <div id="all_img2">
                  <img src="FabbricaIll_1.jpeg" alt="GS"/>
                  <img src="Fabbricaill_4.jpg" alt="GS"/>
                  <img src="FabbricaIll_3.jpg" alt="GS"/>
                </div>

                  <div id="lettera1">

                   <xsl:apply-templates select="//tei:text[@xml:id='t1']"/>
                   
                  </div>
                  <div id="lettera2">
                    <xsl:apply-templates select="//tei:text[@xml:id='t2']"/>
                  </div>
                <div id="all_img3">
                  <img src="figure.tif" alt="GS"/>
                  <img src="Figure2.tif" alt="GS"/>
                  <img src="Figure3.tif" alt="GS"/>
                </div>
                  <div id="chièlafolle">
                     <xsl:apply-templates select="//tei:text[@xml:id='t3']"/>                   
                  </div>
                  <div id="imangiatoridinebbia">
                     <xsl:apply-templates select="//tei:text[@xml:id='t4']"/>
                  </div>
                  <div id="tavole_fonetiche">
                     <xsl:apply-templates select="//tei:text[@xml:id='t5']"/>
                  </div>
                  <div id="fb_provvisorie">
                    <xsl:apply-templates select="//tei:text[@xml:id='t6']"/>
                  </div>
                   <div id="fb_definitiva">
                     <xsl:apply-templates select="//tei:text[@xml:id='t7']"/>                
                   </div>
                  
                </div>
               
            </body>


        </html>
      </xsl:template>


      <!--FUNZIONI E CHIAVI-->


      <!--TEMPLATES TEI-->
    
    <!--FILE DESC e ULTERIORI METADATI-->
    <xsl:template match="tei:sponsor">
      <xsl:for-each select="tei:orgName">
         <xsl:value-of select="."/><text> &#160;&#160;</text>
      </xsl:for-each>
    </xsl:template>  
        
    <xsl:template match="tei:editionStmt">
        <b><xsl:value-of select="tei:edition"/></b><xsl:value-of select="tei:date"/>
        <br />
        <xsl:for-each select="tei:respStmt">
            <b><xsl:value-of select="tei:resp"/></b><xsl:value-of select="tei:name"/>
              <br />
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:publicationStmt">
       <i><xsl:value-of select="tei:availability"/> (<xsl:value-of select="tei:publisher"/>)</i>
    </xsl:template>

    <xsl:template match="tei:listBibl">
     <xsl:for-each select="tei:bibl">
         <xsl:apply-templates select="."/>
     </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:bibl">

      <xsl:element name="div">
       <xsl:attribute name="id">
       <xsl:value-of select="@xml:id"/>
       </xsl:attribute>

       <xsl:for-each select="tei:title">
         <b><xsl:value-of select="."/></b><br />
       </xsl:for-each>
        <xsl:value-of select="tei:author"/><br/>
        <xsl:value-of select="tei:editor"/><br/>
       <xsl:apply-templates select="tei:series"/>
       <br />
       <br />
       <i><xsl:apply-templates select="tei:note"/></i>
      </xsl:element>  
    </xsl:template>

<xsl:template match="//tei:series">
  <xsl:for-each select="*">
   
    <xsl:value-of select="." />
 
    <xsl:if test="position() != last()">
      <xsl:text>, </xsl:text>
    </xsl:if>
  </xsl:for-each>
</xsl:template>








     

      <xsl:template match="tei:text[@xml:id='t1']|tei:text[@xml:id='t2']|tei:text[@xml:id='t3']">
  
         <h2><xsl:value-of select="tei:front/tei:div/tei:head"/></h2>
         <h3><xsl:value-of select="tei:front/tei:div/tei:opener"/></h3>
         <h3><xsl:value-of select="tei:front/tei:div/tei:argument"/></h3>
          <xsl:for-each select="tei:body/tei:div[@xml:id='sx'] | tei:body/tei:div">
            <div class="column_sx">
               
                <xsl:apply-templates select="tei:p"/>
            </div>
            </xsl:for-each>
        
    
 
       <p id="back"><xsl:apply-templates select="tei:back/tei:closer"/></p>  
 
      </xsl:template>

         <xsl:template match="tei:text[@xml:id='t6']">
  
         <h2><xsl:value-of select="tei:front/tei:div/tei:head"/></h2>
         <h3><xsl:value-of select="tei:front/tei:div/tei:opener"/></h3>
         <xsl:apply-templates select="tei:front/tei:div/tei:argument"/>
          <xsl:for-each select="tei:group">
            <div class="column_sx">
               <xsl:apply-templates select="tei:text[@xml:id='t6.1']"/>
               <br />
               <xsl:apply-templates select="tei:text[@xml:id='t6.2']"/>
               <br />
               <xsl:apply-templates select="tei:text[@xml:id='t6.3']"/>
               <br />
               <xsl:apply-templates select="tei:text[@xml:id='t6.4']"/>

            </div>
            </xsl:for-each>
          
 
       <p id="back"><xsl:apply-templates select="tei:back/tei:closer"/></p>  
 
      </xsl:template>

      
      

     <!--I MANGIATORI DI NEBBIA-->
      <xsl:template match="tei:text[@xml:id='t4'] | //tei:text[@xml:id='t6.3'] | //tei:text[@xml:id='t6.4'] | //tei:text[@xml:id='t7']">
         <h2><xsl:value-of select="tei:front/tei:div/tei:head"/></h2>

          <xsl:for-each select="tei:body/tei:div/tei:lg"> 
            <p id="dir"><xsl:apply-templates select="mei:dir/tei:stage"/></p>
              <p class="sezione">
               <xsl:for-each select="tei:l">
                  <xsl:apply-templates />  
                  <br />
               </xsl:for-each>
              </p>       
          </xsl:for-each>
      </xsl:template>

    <xsl:template match="tei:text[@xml:id='t5']">
    <h2><xsl:apply-templates select="tei:front/tei:div/tei:head"/></h2>

          <xsl:for-each select="tei:body/tei:div/tei:lg"> 
              <p class="sezione">
               <xsl:for-each select="tei:l">
                  <xsl:apply-templates />  
                  <br />
               </xsl:for-each>
              </p>       
          </xsl:for-each>  
     </xsl:template>

  <!--FABBRICA ILLUMINATA: STESURE PROVVISORIE-->
    <xsl:template match="//tei:text[@xml:id='t6.1']">
         <h2><xsl:value-of select="tei:front/tei:div/tei:head"/></h2>

          <xsl:for-each select="tei:body/tei:div/tei:lg"> 
            <p id="dir"><xsl:apply-templates select="mei:dir/tei:stage"/></p>
              <p class="sezione">
              
               <xsl:for-each select="tei:sp">
                   <xsl:element name="span">
                      <xsl:attribute name="class">battute</xsl:attribute>
                                        
                         <xsl:for-each select="tei:l">
                           <xsl:apply-templates />  
                       <br />
                 </xsl:for-each>
                </xsl:element>    
               </xsl:for-each>
        
              </p>       
                
          </xsl:for-each>
      </xsl:template>
    <xsl:template match="//tei:text[@xml:id='t6.2']">
         <h2><xsl:value-of select="tei:front/tei:div/tei:head"/></h2>

                     
              <p class="sezione">
               <xsl:for-each select="tei:body/tei:div/tei:lg/tei:l">
                  <xsl:apply-templates />  
                  <br />
               </xsl:for-each>
              </p>       
 
      </xsl:template>

      <!--VERSO-->
      <xsl:template match="//tei:l"> 
         
             <xsl:for-each select="node()[not(self::tei:notatedMusic)]">
                 <xsl:apply-templates />
                 
             </xsl:for-each> 
            
          <xsl:apply-templates select="tei:notatedMusic"/>     
      </xsl:template>


    <!--CORSIVO-->
     <xsl:template match="tei:*[@rend='italic']">
         <i>
            <xsl:apply-templates select="node()"/>
          </i>
     </xsl:template>
    <!--SOTTOLINEATO-->
    <xsl:template match="//tei:*[@rend='underline']">
     
       <span class="underline"><xsl:apply-templates select="node()"/></span> 
   
     </xsl:template>
    <!--GRASSETTO-->
    <xsl:template match="tei:*[@rend='bold']">
         <b>
            <xsl:apply-templates select="node()"/>
          </b>
     </xsl:template>

<!--NOTE TESTUALI-->
<xsl:template match="//tei:ref[@ana]">
    <xsl:element name="span">
        <xsl:attribute name="class">popup</xsl:attribute>
        <xsl:attribute name="id">
            <xsl:value-of select="'popup_'"/>
            <xsl:value-of select="@ana"/>
        </xsl:attribute>
        <xsl:value-of select="key('noteById', @ana)"/>
        <br />
        <xsl:if test="key('noteById', @ana)/@resp">
            <xsl:text> (Responsabile: </xsl:text>
            <xsl:value-of select="key('noteById', @ana)/@resp"/>
            <xsl:text>)</xsl:text>
        </xsl:if>
    </xsl:element>

    <xsl:element name="a">
        <xsl:attribute name="href">#</xsl:attribute>
        <xsl:attribute name="class">popup-trigger</xsl:attribute>
        <xsl:attribute name="id"><xsl:value-of select="@ana"/></xsl:attribute>
        <xsl:number format="[1]" level="any"/>
    </xsl:element>
</xsl:template>

<xsl:template match="tei:argument">
  <div id="arg">
    <xsl:apply-templates />
  </div>
</xsl:template>


      <!--INTERRUZIONE DEL TESTO POETICO-->
      <xsl:template match="//tei:milestone">
          <br />
      </xsl:template>

      <!--SPAZIO INTERNO AL TESTO POETICO-->
      <xsl:template match="//tei:space">  
        <xsl:if test="@quantity='10'">
        
        <xsl:text>
        &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
        &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
        &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
        &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
        &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
         </xsl:if>     
         <xsl:if test="@quantity='5'">
          <xsl:text>
        &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
        &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
        &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
         </xsl:text>
         </xsl:if> 
      </xsl:template>
 
      <!--PARAGRAFI-->
      <xsl:template match="tei:p">
           <p>
                <xsl:element name="span">
                <xsl:attribute name="class">zone</xsl:attribute>
                <xsl:attribute name="id"><xsl:value-of select="@xml:id" /></xsl:attribute>
                <xsl:apply-templates />
                </xsl:element>
           </p>
      </xsl:template>

     <!--TESTO INDENTATO DI NATURA VARIA-->
      <xsl:template match="//tei:floatingText">
         <xsl:for-each select="tei:body">
           <xsl:apply-templates />
         </xsl:for-each>
      </xsl:template>

     <!--SEZIONI TESTUALI DI NATURA VARIA-->
      <xsl:template match="//tei:ab">
      <xsl:text>
       &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
      </xsl:text><xsl:apply-templates />
       
      </xsl:template>

    <!--INTERRUZIONE DI RIGA-->
      <xsl:template match="//tei:lb">
          <br />
    
      </xsl:template>

      <!--CORREZIONI O ALTERNATIVE DI CODIFICA-->
     <xsl:template match="//tei:corr">
        <span class="correzioni" style="display:none;">
        <b><xsl:value-of select="." /></b>
        </span>
    </xsl:template>

    <xsl:template match="//tei:add">
        <span class="correzioni_manoscritte" style="display:none;">
        <b><xsl:value-of select="." /></b>
        </span>
    </xsl:template>

    <xsl:template match="//tei:expan">
        <span class="espansioni" style="display:none;">
        <b><xsl:value-of select="." /></b>
        </span>
    </xsl:template>

    <xsl:template match="tei:sic">
        <xsl:element name="span">
            <xsl:attribute name="class">sic</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:del">
        <xsl:element name="span">
            <xsl:attribute name="class">manoscritte</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>

<!--ABBREVIAZIONI-->
   <xsl:template match="tei:abbr">
        <xsl:element name="span">
            <xsl:attribute name="class">abbr</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>

<!--PERSONE-->
 <xsl:template match="tei:persName">
 <xsl:choose>
  <xsl:when test="@ref">

        <xsl:variable name="id" select="substring-after(@ref, '#')"  />
        
        <!-- Trova il link corrispondente utilizzando la chiave -->
        <xsl:variable name="link" select="key('persName-by-id', $id)/@ref" />  
          
            <xsl:element name="span">
             <xsl:attribute name="class">persone</xsl:attribute>
             <a href="{ $link }">         
                    <xsl:apply-templates />
            </a> 
              </xsl:element> 
    </xsl:when>
    <xsl:otherwise>
     <xsl:element name="span">
            <xsl:attribute name="class">persone</xsl:attribute>
                   <xsl:apply-templates />
        </xsl:element>
    </xsl:otherwise>  
   </xsl:choose>      
    </xsl:template>

    <!--EPITETI-->
    <xsl:template match="//tei:addName">
        <xsl:choose>
          <xsl:when test="@ref">

            <xsl:variable name="id" select="substring-after(@ref, '#')"  />
        
            <!-- Trova il link corrispondente utilizzando la chiave -->
            <xsl:variable name="link" select="key('persName-by-id', $id)/@ref" />  
          
            <xsl:element name="span">
             <xsl:attribute name="class">epithet_rolenames</xsl:attribute>
             <a href="{ $link }">         
                    <xsl:apply-templates />
            </a> 
              </xsl:element> 
            </xsl:when>
           <xsl:otherwise>
              <xsl:element name="span">
                  <xsl:attribute name="class">epithet_rolenames</xsl:attribute>
                   <xsl:apply-templates />
            </xsl:element>
           </xsl:otherwise>  
        </xsl:choose>      
    </xsl:template>

<!--LOCAZIONI GEOGRAFICHE-->
    <xsl:template match="tei:country">
        <xsl:element name="span">
            <xsl:attribute name="class">Luoghi_countries</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>
 <xsl:template match="tei:region">
        <xsl:element name="span">
            <xsl:attribute name="class">Luoghi_countries</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>
 <xsl:template match="tei:term[@type='geopolitical']">
        <xsl:element name="span">
            <xsl:attribute name="class">Luoghi_countries</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

 <xsl:template match="tei:settlement">
        <xsl:element name="span">
            <xsl:attribute name="class">Luoghi_settlements</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>



<!--CITAZIONI-->
<xsl:template match="//tei:quote">
  <xsl:choose>
    <xsl:when test="@type eq 'inchiesta'">
        <xsl:element name="span">
            <xsl:attribute name="class">quotes2</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:when>
    <xsl:when test="@type eq 'cp'">
        <xsl:element name="span">
            <xsl:attribute name="class">quotes3</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:when>
    <xsl:otherwise>
        <xsl:element name="span">
            <xsl:attribute name="class">quotes</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:otherwise>
  </xsl:choose>
       
</xsl:template>

<!--ORGANIZZAZIONI-->
<xsl:template match="tei:orgName">
       <xsl:choose>
  <xsl:when test="@ref">

        <xsl:variable name="id" select="substring-after(@ref, '#')"  />
        
        <!-- Trova il link corrispondente utilizzando la chiave -->
        <xsl:variable name="link" select="key('org-by-id', $id)/tei:orgName/@ref" />  
          
            <xsl:element name="span">
             <xsl:attribute name="class">org</xsl:attribute>
             <a href="{ $link }">         
            <xsl:apply-templates />
            </a> 
              </xsl:element> 
    </xsl:when>
    <xsl:otherwise>
     <xsl:element name="span">
            <xsl:attribute name="class">org</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:otherwise>  
   </xsl:choose>       
</xsl:template>

<!--TERMINI AFFERENTI ALLA SFERA/CONDIZIONE SOCIOECONOMICA-->
 <xsl:template match="tei:term[@type='socio-economic']">
        <xsl:element name="span">
            <xsl:attribute name="class">socioeconomic</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

 <xsl:template match="tei:roleName[@type='socialstatus']">
        <xsl:element name="span">
            <xsl:attribute name="class">socioeconomic</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

 <xsl:template match="tei:term[@type='religious']">
        <xsl:element name="span">
            <xsl:attribute name="class">socioeconomic</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

<xsl:template match="tei:term[@type='workingcond']">
        <xsl:element name="span">
            <xsl:attribute name="class">condizionidilavoro</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

<!--PER LE LETTERE: RIFERIMENTI AI DESTINATARI-->

<xsl:template match="tei:term[@type='interlocutore']">
        <xsl:element name="span">
            <xsl:attribute name="class">destinatario</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

<xsl:template match="tei:term[@type='comunità']">
        <xsl:element name="span">
            <xsl:attribute name="class">comunità</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

<!--SFERA PSICOLOGICA-->
<xsl:template match="tei:term[@type='psycological']">
        <xsl:element name="span">
            <xsl:attribute name="class">psy</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

<!--EVENTI STORICI-->

<xsl:template match="tei:term[@type='storicalevent']">
        <xsl:element name="span">
            <xsl:attribute name="class">eventistorici</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

<xsl:template match="tei:date">
        <xsl:element name="span">
            <xsl:attribute name="class">Date</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

<xsl:template match="tei:dateline">
        <xsl:element name="span">
            <xsl:attribute name="class">Date</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

<!--OPERE-->

<xsl:template match="tei:title">
        <xsl:element name="span">
            <xsl:attribute name="class">ref_bibl</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

<!--NOMI-->

<xsl:template match="tei:roleName">
        <xsl:element name="span">
            <xsl:attribute name="class">epithet_rolenames</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

<!--CORREZIONI/AGGIUNTE MANOSCRITTE-->
<xsl:template match="tei:retrace">
        <xsl:element name="span">
            <xsl:attribute name="class">manoscritte</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

<!--INTERPRETAZIONE INCERTA-->
<xsl:template match="tei:unclear">
  
        <xsl:element name="span">
            <xsl:attribute name="class">uncl</xsl:attribute>        
            <xsl:apply-templates /> 
        </xsl:element>
      
</xsl:template>

<!--ANTROPOS-->
 <xsl:template match="tei:term[@type='uomo']">
        <xsl:element name="span">
            <xsl:attribute name="class">umano</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

<!--LA MACCHINA-->
 <xsl:template match="tei:term[@type='fabbrica']">
        <xsl:element name="span">
            <xsl:attribute name="class">fabbrica</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>

<!--TECNICISMI/TERMINI TRATTI DALLA CONTEMPORANEITA-->
 <xsl:template match="tei:term[@type='tec']">
        <xsl:element name="span">
            <xsl:attribute name="class">tecnicismi</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
</xsl:template>


<!--TEMPLATES MEI-->

      <xsl:template match="//mei:dir[@type='loud']">
        <xsl:element name="span">
            <xsl:attribute name="class">acuto</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
      </xsl:template>

    <xsl:template match="//mei:dir[@type='solo']">
        <xsl:element name="span">
            <xsl:attribute name="class">solo</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
      </xsl:template>

    <xsl:template match="//mei:dir[@type='spazi']">
        <xsl:element name="span">
            <xsl:attribute name="class">spazi</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
      
    <xsl:template match="//tei:stage">
        <xsl:element name="span">
            <xsl:attribute name="class">scenografia</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
      </xsl:template>

      <xsl:template match="//mei:breath">
       <xsl:element name="span">
        <xsl:attribute name="class">pausa</xsl:attribute>
        <xsl:choose>
           <xsl:when test="@xml:id = 'longbreath'">
               <svg xmlns="http://www.w3.org/2000/svg" width="7%" height="30px">
                  <line x1="0" y1="29" x2="100" y2="29" stroke="black" stroke-width="2"/>
                 </svg>
           </xsl:when>
           <xsl:otherwise>
            <b><xsl:value-of select="."/></b>
           </xsl:otherwise>
        </xsl:choose>
        </xsl:element>
       
      </xsl:template>

     
     
      <xsl:template match="//tei:notatedMusic">
   
     <xsl:variable name="xPosition" select="0"/>
       <xsl:variable name="lineLength" select="count(.//mei:note | .//mei:beam/mei:note)*55"/>
      
      <svg xmlns="http://www.w3.org/2000/svg" class="not_mus" width="100%">
            <!-- pentagramma -->
            <xsl:for-each select="0 to 4">
                <line x1="{$lineXStart}" x2="{$lineXStart + $lineLength}"
                    y1="{$lineYStart + (current()*$lineBuffer)}"
                    y2="{$lineYStart + (current()*$lineBuffer)}" stroke="black" stroke-width="1"/>
            </xsl:for-each>
           
            <rect x="{$lineXStart + $lineLength - 3}" width="3" y="{$lineYStart}" height="{4*$lineBuffer}" fill="black"></rect>
            <rect x="{$lineXStart + $lineLength - 6}" width="1" y="{$lineYStart}" height="{4*$lineBuffer}" fill="black"></rect>
            <!-- chiave di violino -->
            <image href="trebleClef.png" x="{$lineXStart}" y="{$lineYStart - 18}" height="80"
                width="33"/>

            
            <xsl:for-each select="mei:section/mei:measure/mei:staff/mei:layer/(mei:beam|mei:chord|mei:note)">

            <!-- La variabile xPosition calcola la posizione orizzontale (potenzialmente in termini di coordinate) 
            della nota corrente in un sistema musicale, tenendo conto dei seguenti fattori:
            Il numero di note precedenti non legate (escluse quelle in un mei:beam).
            Il numero di accordi e elementi mei:est precedenti.
            La somma della posizione orizzontale delle legature di portamento (mei:beam), che dipende 
            dal numero di note in ciascuna legatura.
            La distanza di spazio orizzontale tra gli oggetti, definita da $itemBuffer.
            La posizione iniziale della nota, definita da $noteXStart.
            Il risultato finale di questa formula è una posizione orizzontale, che probabilmente viene 
            usata per allineare correttamente la nota nella partitura musicale o in un diagramma di notazione.-->
            
         <xsl:variable name="xPosition">
            <xsl:value-of select="(count(preceding-sibling::mei:beam) + count(preceding-sibling::chord) + count(preceding-sibling::mei:note) + count(preceding-sibling::mei:beam/mei:note)) * $itemBuffer + $startingValue"/>
        </xsl:variable>

             
        

                <xsl:choose>

                 <!--GESTIONE BEAM-->

                   <xsl:when test="name() eq 'mei:beam'">
                <!--calcolo della estensione del beam sul pentagramma-->   
                       <xsl:variable name="stemLength">
                           <xsl:choose>
                               <xsl:when test="avg(/mei:note/number(@oct)) ge 4">
                                   <xsl:value-of select="35"/>
                               </xsl:when>
                              <xsl:otherwise>
                                   <xsl:value-of select="-35"/>
                              </xsl:otherwise>
                           </xsl:choose>
                       </xsl:variable>

           
                       <xsl:variable name="beamHeight">
                           <xsl:choose>
                               <xsl:when test="avg(/mei:note/number(@oct)) ge 4">
                                   <xsl:value-of select="6"/>
                               </xsl:when>
                               <xsl:otherwise>
                                   <xsl:value-of select="-6"/>
                               </xsl:otherwise>
                           </xsl:choose>
                       </xsl:variable>

                       <xsl:variable name="stemOffset">
                           <xsl:choose>
                               <xsl:when test="avg(/mei:note/number(@oct)) ge 4">
                                   <xsl:value-of select="-$noteXRadius"/>
                              </xsl:when>
                              <xsl:otherwise>
                                   <xsl:value-of select="$noteXRadius"/>
                               </xsl:otherwise>
                           </xsl:choose>
                       </xsl:variable>

              
              <!-- Calcolare la posizione verticale per la prima e ultima nota -->
                    <xsl:variable name="y1"
                        select="($middleCYPosition + (mei:note[1]/@oct - 4)*(-35)) - number(translate(mei:note[1]/@pname, 'cdefgab', '0123456'))*$ledgerBuffer"/>
                    
                    <xsl:variable name="y2"
                        select="($middleCYPosition + (mei:note[last()]/@oct - 4)*(-35)) - number(translate(mei:note[last()]/@pname, 'cdefgab', '0123456'))*$ledgerBuffer"/>

                  <!-- Calcolare la lunghezza del beam -->
                   <xsl:variable name="beamLength" select="(count(.//mei:note) - 1) * $itemBuffer"/>

                <!-- Nel caso di beam senza chords -->
                <xsl:if test="@class = 'beam'">
             
                  <!-- Calcolare la lunghezza del beam -->
                   <xsl:variable name="beamLength" select="(count(.//mei:note) - 1) * $itemBuffer"/>

                   <!--Poligono di legatura-->
                   <polygon
                     points="{$xPosition + $stemOffset},{$y1 + $stemLength}
                     {$xPosition + $stemOffset},{$y1 + $stemLength - $beamHeight}
                     {$xPosition + $beamLength + $stemOffset},{$y2 + $stemLength - $beamHeight}
                     {$xPosition + $beamLength + $stemOffset},{$y2 + $stemLength}"
                     fill="black"/>


                </xsl:if>

               <!--aggiunta della var slope che calcola la differenza di la differenza 
                di altezza tra la posizione verticale dell'ultima e della prima nota, 
                 divisa per il numero di note. Slope è utile a regolare l'altezza dell'inclinatura del 
                 poligono di congiuntura-->
                  <xsl:variable name="slope" select="($y2 - $y1) div (count(.//mei:note)-1)"/>
       
         <!--Nel caso di Beams con Chords-->
          <xsl:if test="@class = 'chord'">
                <xsl:variable name="stemLength">
                           <xsl:choose>
                               <xsl:when test="avg(/mei:note[@beam = 'i1']/number(@oct)) ge 4">
                                   <xsl:value-of select="34"/>
                               </xsl:when>
                              <xsl:otherwise>
                                   <xsl:value-of select="-34"/>
                              </xsl:otherwise>
                           </xsl:choose>
                       </xsl:variable>

                 
                       <xsl:variable name="beamHeight">
                           <xsl:choose>
                               <xsl:when test="avg(/mei:note[@beam = 'i1']/number(@oct)) ge 4">
                                   <xsl:value-of select="6"/>
                               </xsl:when>
                               <xsl:otherwise>
                                   <xsl:value-of select="-6"/>
                               </xsl:otherwise>
                           </xsl:choose>
                       </xsl:variable>

                       <xsl:variable name="stemOffset">
                           <xsl:choose>
                               <xsl:when test="avg(/mei:note[@beam = 'i1']/number(@oct)) ge 4">
                                   <xsl:value-of select="-$noteXRadius"/>
                              </xsl:when>
                              <xsl:otherwise>
                                   <xsl:value-of select="$noteXRadius"/>
                               </xsl:otherwise>
                           </xsl:choose>
                       </xsl:variable>

                   <!-- Trova la prima nota con beam='i' -->
                   <xsl:variable name="firstI" select="mei:note[@beam='i1'][1]"/>
                   <xsl:variable name="lastI" select="mei:note[@beam='i1'][last()]"/>
                    <xsl:message select="$lastI"/>
    
                   <!-- Calcola la posizione verticale y1 della prima nota -->
                   <xsl:variable name="y1" select="($middleCYPosition + ($firstI/@oct - 4) * (-35)) - number(translate($firstI/@pname, 'cdefgab', '0123456')) * $ledgerBuffer"/>
                   <xsl:message select="$y1"/>
                   <!-- Calcola la posizione verticale y2 dell'ultima nota con beam='i' -->
                   <xsl:variable name="y2" select="($middleCYPosition + ($lastI/@oct - 4) * (-35)) - number(translate($lastI/@pname, 'cdefgab', '0123456')) * $ledgerBuffer"/>
                    <xsl:message select="$y2"/>
                   <!-- Calcola la lunghezza del beam basata sulla posizione delle note con beam='i' -->
                   <xsl:variable name="beamLength" select="(count(mei:note[@beam='i1']) - 1) * $itemBuffer"/>

                   <xsl:variable name="slope" select="($y2 - $y1) div (count(.//mei:note)-1)"/>

                   <!-- Disegna il poligono del beam -->
                   <polygon
                       points="{$xPosition + $stemOffset},{$y1 + $stemLength}
                               {$xPosition + $stemOffset},{$y1 + $stemLength - $beamHeight}
                               {$xPosition + $beamLength * 2 + $stemOffset},{$y2 + $stemLength - $beamHeight}
                               {$xPosition + $beamLength * 2 + $stemOffset},{$y2 + $stemLength}"
                       fill="black"/> 

                        
            </xsl:if>
      

            <!-- GESTIONE DELLE NOTE INTERNE AL BEAM -->
                <xsl:for-each select="mei:note">


                <!--yPosition: posizione verticale dell'ellisse e del gambo della nota-->
                 <xsl:variable name="position" select="position()"/>
                     <xsl:variable name="yPosition"
                  select="($middleCYPosition + (@oct - 4)*(-35)) - number(translate(@pname, 'cdefgab', '0123456'))*$ledgerBuffer"/>

        
                 
                 <!-- Verifica se la nota è parte del beam 'i1' o 't1' cioè se c'è un chord-->
                <xsl:if test="((@beam = 't1') and not(preceding-sibling::mei:note[@beam='m1'])) or (@beam='m1')">     
                    
                    <xsl:if test="number(@dur) ge 4">
                      <ellipse cx="{$xPosition + ((position() - 2) * $itemBuffer)}" cy="{$yPosition}" rx="6" ry="5" fill="black"/>
                    </xsl:if>
                    <xsl:if test="number(@dur) le 2">
                       <ellipse cx="{$xPosition + ((position() - 2) * $itemBuffer)}" cy="{$yPosition}"  rx="6" ry="5" stroke="black"
                       stroke-width="1.5" fill="none"/>     
                    </xsl:if>

                   
                      <!--stanga delle note coinvolte nel beam-->
                              <line x1="{$xPosition + ((position() - 2) * $itemBuffer) + $stemOffset}"
                                  x2="{$xPosition + ((position() - 2) * $itemBuffer) + $stemOffset}"
                                  y1="{$yPosition}" y2="{$y1 + (($position - 1) * $slope) + $stemLength}" stroke="black"
                                  stroke-width="1.5"/>



                       <xsl:variable name="xPosition">
                          <!-- Conta il numero di note precedenti e beam precedenti nell'elemento attuale -->
                               <xsl:value-of select="
                                (count(preceding-sibling::mei:beam) + 
                                count(preceding-sibling::mei:note) + 
                                count(preceding-sibling::mei:beam/mei:note))
                               * $itemBuffer + $noteXStart"/>
                            </xsl:variable>


              
                             <xsl:variable name="yPosition">
                                <xsl:value-of select="($middleCYPosition + (@oct - 4)*(-35)) - number(translate(@pname, 'cdefgab', '0123456'))*$ledgerBuffer"/>
                            </xsl:variable>
                    
                    <!--Gestione sillabe -->
                     <xsl:choose>
                        <xsl:when test="mei:verse/mei:syl">
                           <xsl:if test="mei:verse/mei:syl[@con='s']">                  
                              <text x="{$xPosition + ((position() - 1) * $itemBuffer)}" y="{$yPosition + 40}" font-size="17" fill="black">
                                 <xsl:value-of select="."/>  
                              </text>
                            </xsl:if> 
                            <xsl:if test="mei:verse/mei:syl[@con='d']">                  
                              <text x="{$xPosition + ((position() - 1) * $itemBuffer)}" y="{$yPosition + 40}" font-size="17" fill="black">
                                 <xsl:value-of select="."/> &#45;  
                              </text>
                            </xsl:if> 
                        </xsl:when>
                     </xsl:choose>
                </xsl:if>

                <xsl:if test="(@beam='t1') and (preceding-sibling::mei:note[@beam='m1'])">
                
                    <xsl:if test="number(@dur) ge 4">
                      <ellipse cx="{$xPosition + ((position() - 3) * $itemBuffer)}" cy="{$yPosition}" rx="6" ry="5" fill="black"/>
                    </xsl:if>
                    <xsl:if test="number(@dur) le 2">
                       <ellipse cx="{$xPosition + ((position() - 3) * $itemBuffer)}" cy="{$yPosition}"  rx="6" ry="5" stroke="black"
                       stroke-width="1.5" fill="none"/>     
                    </xsl:if>
                      <!--stanga delle note coinvolte nel beam-->
                              <line x1="{$xPosition + ((position() - 3) * $itemBuffer) + $stemOffset}"
                                  x2="{$xPosition + ((position() - 3) * $itemBuffer) + $stemOffset}"
                                  y1="{$yPosition}" y2="{$y1 + (($position - 1) * $slope) + $stemLength}" stroke="black"
                                  stroke-width="1.5"/>
                    
                               <xsl:choose>
                                     <xsl:when test="$yPosition gt ($middleCYPosition - $lineBuffer*.5)">
                                       <xsl:for-each
                                        select="0 to (($yPosition - $middleCYPosition) idiv $lineBuffer)">
                                        <line
                                            x1="{$xPosition +(($position - 3)*$itemBuffer) - ($noteXRadius + $ledgerBuffer)}"
                                            x2="{$xPosition +(($position - 3)*$itemBuffer) + $noteXRadius + $ledgerBuffer}"
                                            y1="{$middleCYPosition + (position()-1)*$lineBuffer}"
                                            y2="{$middleCYPosition + (position()-1)*$lineBuffer}"
                                            stroke="black" stroke-width="1.5"/>
                                       </xsl:for-each>
                                </xsl:when>
                                <xsl:when test="$yPosition lt ($middleCYPosition - $lineBuffer*5.5)">
                                    <xsl:for-each
                                        select="0 to ((($middleCYPosition - $lineBuffer*6) - $yPosition) idiv $lineBuffer)">
                                        <line
                                            x1="{$xPosition +(($position - 3)*$itemBuffer) - ($noteXRadius + $ledgerBuffer)}"
                                            x2="{$xPosition+(($position - 3)*$itemBuffer) + $noteXRadius + $ledgerBuffer}"
                                            y1="{($middleCYPosition - $lineBuffer*6) - (position()-1)*$lineBuffer}"
                                            y2="{($middleCYPosition - $lineBuffer*6) - (position()-1)*$lineBuffer}"
                                            stroke="black" stroke-width="1.5"/>
                                    </xsl:for-each>
                                </xsl:when>
                            </xsl:choose>                          


                </xsl:if>

                <!--gestione note interne in assenza di chord-->
                <xsl:if test="not(@beam='t1') and not(@beam='m1') or not(@beam)">

                      <xsl:if test="number(@dur) ge 4">
                         <ellipse cx="{$xPosition + ((position() - 1) * $itemBuffer)}" cy="{$yPosition}" rx="6" ry="5" fill="black"/>
                       </xsl:if>
                       <xsl:if test="number(@dur) le 2">
                            <ellipse cx="{$xPosition + ((position() - 1) * $itemBuffer)}" cy="{$yPosition}"  rx="6" ry="5" stroke="black"
                                    stroke-width="1.5" fill="none"/>     
                        </xsl:if>
                            <!--poligono di legatura tra le note coinvolte nel beam-->

                              <line x1="{$xPosition + ((position() - 1) * $itemBuffer) + $stemOffset}"
                                  x2="{$xPosition + ((position() - 1) * $itemBuffer) + $stemOffset}"
                                  y1="{$yPosition}" y2="{$y1 + (($position - 1) * $slope) + $stemLength}" stroke="black"
                                  stroke-width="1.5"/>
            

                                   <xsl:choose>
                                     <xsl:when test="$yPosition gt ($middleCYPosition - $lineBuffer*.5)">
                                       <xsl:for-each
                                        select="0 to (($yPosition - $middleCYPosition) idiv $lineBuffer)">
                                        <line
                                            x1="{$xPosition +(($position - 1)*$itemBuffer) - ($noteXRadius + $ledgerBuffer)}"
                                            x2="{$xPosition +(($position - 1)*$itemBuffer) + $noteXRadius + $ledgerBuffer}"
                                            y1="{$middleCYPosition + (position()-1)*$lineBuffer}"
                                            y2="{$middleCYPosition + (position()-1)*$lineBuffer}"
                                            stroke="black" stroke-width="1.5"/>
                                       </xsl:for-each>
                                </xsl:when>
                                <xsl:when test="$yPosition lt ($middleCYPosition - $lineBuffer*5.5)">
                                    <xsl:for-each
                                        select="0 to ((($middleCYPosition - $lineBuffer*6) - $yPosition) idiv $lineBuffer)">
                                        <line
                                            x1="{$xPosition +(($position - 1)*$itemBuffer) - ($noteXRadius + $ledgerBuffer)}"
                                            x2="{$xPosition+(($position - 1)*$itemBuffer) + $noteXRadius + $ledgerBuffer}"
                                            y1="{($middleCYPosition - $lineBuffer*6) - (position()-1)*$lineBuffer}"
                                            y2="{($middleCYPosition - $lineBuffer*6) - (position()-1)*$lineBuffer}"
                                            stroke="black" stroke-width="1.5"/>
                                    </xsl:for-each>
                                </xsl:when>
                            </xsl:choose>                            
                   </xsl:if>

                           <!--controlla se sono presenti attributi @accid-->
                              <xsl:choose>
                                  <xsl:when test="@accid eq 'f'">
                                    
                                      <image preserveAspectRatio="none" href="flat.png" height="23" width="15"
                                          x="{$xPosition - $flatXOffset + (position()-1)*$itemBuffer}" y="{$yPosition - $flatYOffset}"/>
                             
                                  </xsl:when>
                                  <xsl:when test="@accid eq 'ff'">
                                      <image preserveAspectRatio="none" href="flat.png" height="23" width="15"
                                          x="{$xPosition - $flatXOffset + (position()-1)*$itemBuffer}" y="{$yPosition - $flatYOffset}"/>
                                          <image preserveAspectRatio="none" href="flat.png" height="23" width="15"
                                          x="{$xPosition - $flatXOffset + (position()-1)*$itemBuffer}" y="{$yPosition - $flatYOffset*2}"/>
                                  </xsl:when>
                                  
                                  <xsl:when test="@accid eq 's'">                                 
                                     <image preserveAspectRatio="none" href="sharp.png" height="22" width="22"
                                          x="{$xPosition - $sharpXOffset + (position()-1)*$itemBuffer}" y="{$yPosition - $sharpYOffset}"/>
                     
                                  </xsl:when>
                                  <xsl:when test="@accid eq 'n'">
                                      <image preserveAspectRatio="none" href="natural.png" height="23" width="15"
                                          x="{$xPosition - $noteXRadius*2 - 6 + (position()-1)*$itemBuffer}" y="{$yPosition - $noteYRadius - 9}"/>
                                  </xsl:when>
                              </xsl:choose>

                               <!--Gestione di eventuali harm per le note interne al beam-->
                              <xsl:if test="(preceding-sibling::mei:harm[1]) and (not(preceding-sibling::mei:note) or (@beam='i1'))">
                               <xsl:message select="'ok'"/>

                                <!-- Elemento di testo con valore -->
                                <text x="{$xPosition}" y="{20}">
                                    <xsl:value-of select="preceding-sibling::mei:harm/mei:fb/mei:f"/>
                                </text>
                          </xsl:if>


                   <!--Posizione le sillabe del verso poetico sotto le note corrispondenti, usando un metodo simile al
                   posizionamento delle immagini relative ai valorid dell'attributo @accid-->
                              <xsl:choose>
                                <xsl:when test="not(@beam='t1')">
                                   <xsl:if test="mei:verse/mei:syl[@con='s']">                  
                                     <text x="{$xPosition + ((position() - 1) * $itemBuffer) -10}" y="{115}" font-size="15" fill="black">
                                      <xsl:value-of select="."/> 
                                         </text>
                                    </xsl:if> 
                                    <xsl:if test="mei:verse/mei:syl[@con='d']">                  
                                       <text x="{$xPosition + ((position() - 1) * $itemBuffer) -10}" y="{115}" font-size="15" fill="black">
                                          <xsl:value-of select="."/> &#45; 
                                      </text>                            
                                </xsl:if>
                               </xsl:when> 
                              </xsl:choose>


                        
                               <xsl:if test="@tie and not(@beam)">

                                <xsl:choose>
                               <!-- Se il tie è 'i', salva i valori di posizione -->
                                  <xsl:when test="@tie eq 'i'">
                                    <xsl:variable name="x0" select="$xPosition + ((position() - 1) * $itemBuffer) + $stemOffset"/>
                                    <xsl:variable name="y0" select="$yPosition"/>
                                    <!-- Spazio sopra la nota per la curva -->
                                    <xsl:variable name="offsetSpace" select="10"/>
                                    <!-- Qui usiamo le variabili appena definite -->
                                    <xsl:message select="concat('Salvati Xpos: ', $x0, ' Ypos: ', $y0)"/>

                                  <xsl:for-each select="following::mei:note[@tie='t'][1]">

                                    <xsl:variable name="x1" select="((count(preceding-sibling::mei:note) + count(preceding-sibling::mei:beam/mei:note) + count(preceding-sibling::mei:beam)) * $itemBuffer) + $noteXStart"/>
                                    <xsl:variable name="y1" select="($middleCYPosition + (@oct - 4)*(-35)) - number(translate(@pname, 'cdefgab', '0123456'))*$ledgerBuffer"/>
                                    <!-- Valori per una curva più morbida -->
                                     <!-- Punti di controllo per una curva più dolce sopra le note -->
                                    <xsl:variable name="controlX0" select="($x0 + $x1) div 2"/>
                                    <xsl:variable name="controlY0" select="($y0 + $y1) div 2"/>
                                   
                                    <xsl:variable name="controlX1" select="($x0 + $x1) div 2"/>
                                    <xsl:variable name="controlY1" select="($y0 + $y1 - 80) - $offsetSpace"/>

                                    <!-- Sposta gli estremi della curva sopra la nota -->
                                    <xsl:variable name="x0Offset" select="($x0 + 2)"/> <!-- Spostamento in orizzontale del punto iniziale della curva -->
                                    <xsl:variable name="y0Offset" select="($y0 - $offsetSpace*2)"/> <!-- Spostamento in verticale del punto iniziale della curva -->
            
                                    <xsl:variable name="x1Offset" select="($x1 + 2)"/> <!-- Spostamento in orizzontale del punto finale della curva -->
                                    <xsl:variable name="y1Offset" select="($y1 - $offsetSpace*2)"/> <!-- Spostamento in verticale del punto finale della curva -->
            
                                    <!-- Disegna la legatura con una curva sopra le note -->
                                    <path d="M{$x0Offset},{$y0Offset} C{$controlX0},{$controlY0 - 10} {$controlX1},{$controlY1} {$x1Offset},{$y1Offset}" 
                                        fill="transparent" stroke="black" stroke-width="2"/>

                                  </xsl:for-each>
                                  <xsl:choose>
                                    <xsl:when test="not(following::mei:note[@tie='t'][1])">
                                          <image preserveAspectRatio="none" href="legatura.png" height="23" width="15"
                                          x="{$x0 - 30}" y="{$yPosition - $flatYOffset}"/>
                                    </xsl:when>
                                  </xsl:choose>       
                                 </xsl:when>       
                               </xsl:choose>
                               </xsl:if>

                           <xsl:if test="@tie and @beam">

                                <xsl:choose>
                               <!-- Se il tie è 'i', salva i valori di posizione -->
                                  <xsl:when test="@tie eq 'i' and (@beam eq 'i1' or @beam eq 'm1')">
                                    <xsl:variable name="x0" select="$xPosition + ((position() - 1) * $itemBuffer) + $stemOffset"/>
                                    <xsl:variable name="y0" select="$yPosition"/>
                                    <!-- Spazio sopra la nota per la curva -->
                                    <xsl:variable name="offsetSpace" select="10"/>
                                    <!-- Qui usiamo le variabili appena definite -->
                                    <xsl:message select="concat('Salvati Xpos: ', $x0, ' Ypos: ', $y0)"/>

                                  <xsl:for-each select="following::mei:note[@tie='t'][1]">

                                    <xsl:variable name="x1" select="((count(preceding-sibling::mei:note) + count(preceding-sibling::mei:beam/mei:note) + count(preceding-sibling::mei:beam)  - count(preceding-sibling::mei:beam[@class='chord'])) * $itemBuffer) + $noteXStart"/>
                                    <xsl:variable name="y1" select="($middleCYPosition + (@oct - 4)*(-35)) - number(translate(@pname, 'cdefgab', '0123456'))*$ledgerBuffer"/>
                                    <!-- Valori per una curva più morbida -->
                                     <!-- Punti di controllo per una curva più dolce sopra le note -->
                                    <xsl:variable name="controlX0" select="($x0 + $x1) div 2"/>
                                    <xsl:variable name="controlY0" select="($y0 + $y1) div 2"/>
                                  
                                    <xsl:variable name="controlX1" select="($x0 + $x1) div 2"/>
                                    <xsl:variable name="controlY1" select="($y0 + $y1 - 80) - $offsetSpace"/>

                                    <!-- Sposta gli estremi della curva sopra la nota -->
                                    <xsl:variable name="x0Offset" select="($x0 + 2)"/> <!-- Spostamento in orizzontale del punto iniziale della curva -->
                                    <xsl:variable name="y0Offset" select="($y0 - $offsetSpace*2)"/> <!-- Spostamento in verticale del punto iniziale della curva -->
            
                                    <xsl:variable name="x1Offset" select="($x1 + 2)"/> <!-- Spostamento in orizzontale del punto finale della curva -->
                                    <xsl:variable name="y1Offset" select="($y1 - $offsetSpace*2)"/> <!-- Spostamento in verticale del punto finale della curva -->
            
                                    <!-- Disegna la legatura con una curva sopra le note -->
                                    <path d="M{$x0Offset},{$y0Offset} C{$controlX0},{$controlY0 - 10} {$controlX1},{$controlY1} {$x1Offset},{$y1Offset}" 
                                        fill="transparent" stroke="black" stroke-width="2"/>

                                  </xsl:for-each>
                                  <xsl:choose>
                                      
                                       <xsl:when test="not(following::mei:note[@tie='t'][1])">
                                       <xsl:if test="@beam eq 'm1'">
                                        <xsl:variable name="x0" select="$xPosition + ((position() - 2) * $itemBuffer) + $stemOffset"/>
                                           <image preserveAspectRatio="none" href="legatura.png" height="23" width="15"
                                          x="{$x0 - 30}" y="{$yPosition - $flatYOffset}"/>
                                       </xsl:if>
                                       <xsl:if test="@beam eq 'i1'">
                                        <image preserveAspectRatio="none" href="legatura.png" height="23" width="15"
                                          x="{$x0 - 30}" y="{$yPosition - $flatYOffset }"/>
                                       </xsl:if>
                                         
                                    </xsl:when>
                                  </xsl:choose>       
                                 </xsl:when> 
                                 <xsl:when test="@tie eq 'i' and @beam eq 't1' and not(preceding::mei:note[@beam='m1'])">                        
                                   <xsl:variable name="x0" select="$xPosition + ((position() - 2) * $itemBuffer) + $stemOffset"/>

                                    <xsl:variable name="y0" select="$yPosition"/>
                                    <!-- Spazio sopra la nota per la curva -->
                                    <xsl:variable name="offsetSpace" select="10"/>
                                    
                                    <xsl:message select="concat('Salvati Xpos: ', $x0, ' Ypos: ', $y0)"/>

                                  <xsl:for-each select="following::mei:note[@tie='t'][1]">

                                    <xsl:variable name="x1" select="((count(preceding-sibling::mei:note) + count(preceding-sibling::mei:beam/mei:note) + count(preceding-sibling::mei:beam) - count(preceding-sibling::mei:beam[@class='chord'])) * $itemBuffer) + $noteXStart"/>
                                    <xsl:variable name="y1" select="($middleCYPosition + (@oct - 4)*(-35)) - number(translate(@pname, 'cdefgab', '0123456'))*$ledgerBuffer"/>
                                    <!-- Valori per una curva più morbida -->
                                     <!-- Punti di controllo per una curva più dolce sopra le note -->
                                    <xsl:variable name="controlX0" select="($x0 + $x1) div 2"/>
                                    <xsl:variable name="controlY0" select="($y0 + $y1) div 2"/>
                                    
                                    <xsl:variable name="controlX1" select="($x0 + $x1) div 2"/>
                                    <xsl:variable name="controlY1" select="($y0 + $y1 - 80) - $offsetSpace"/>

                                    <!-- Sposta gli estremi della curva sopra la nota -->
                                    <xsl:variable name="x0Offset" select="($x0 + 2)"/> <!-- Spostamento in orizzontale del punto iniziale della curva -->
                                    <xsl:variable name="y0Offset" select="($y0 - $offsetSpace*2)"/> <!-- Spostamento in verticale del punto iniziale della curva -->
            
                                    <xsl:variable name="x1Offset" select="($x1 + 2)"/> <!-- Spostamento in orizzontale del punto finale della curva -->
                                    <xsl:variable name="y1Offset" select="($y1 - $offsetSpace*2)"/> <!-- Spostamento in verticale del punto finale della curva -->
            
                                    <!-- Disegna la legatura con una curva sopra le note -->
                                    <path d="M{$x0Offset},{$y0Offset} C{$controlX0},{$controlY0 - 10} {$controlX1},{$controlY1} {$x1Offset},{$y1Offset}" 
                                        fill="transparent" stroke="black" stroke-width="2"/>

                                  </xsl:for-each>
                                  <xsl:choose>
                                     <xsl:when test="not(following::mei:note[@tie='t'][1])">
                                         
                                          <image preserveAspectRatio="none" href="legatura.png" height="23" width="15"
                                          x="{$x0 - 30}" y="{$yPosition - $flatYOffset}"/>

                                    </xsl:when>
                                  </xsl:choose>       
                                 </xsl:when>

                                 <xsl:when test="@tie eq 'i' and @beam eq 't1' and preceding::mei:note[@beam='m1']">                        
                                   <xsl:variable name="x0" select="$xPosition + ((position() - 3))"/>

                                    <xsl:variable name="y0" select="$yPosition"/>
                                    <!-- Spazio sopra la nota per la curva -->
                                    <xsl:variable name="offsetSpace" select="10"/>
                                   
                                    <xsl:message select="concat('Salvati Xpos: ', $x0, ' Ypos: ', $y0)"/>

                                  <xsl:for-each select="following::mei:note[@tie='t'][1]">

                                    <xsl:variable name="x1" select="((count(preceding-sibling::mei:note) + count(preceding-sibling::mei:beam/mei:note) + count(preceding-sibling::mei:beam) - count(preceding-sibling::mei:beam[@class='chord'])) * $itemBuffer) + $noteXStart"/>
                                    <xsl:variable name="y1" select="($middleCYPosition + (@oct - 4)*(-35)) - number(translate(@pname, 'cdefgab', '0123456'))*$ledgerBuffer"/>
                                    <!-- Valori per una curva più morbida -->
                                     <!-- Punti di controllo per una curva più dolce sopra le note -->
                                    <xsl:variable name="controlX0" select="($x0 + $x1) div 2"/>
                                    <xsl:variable name="controlY0" select="($y0 + $y1) div 2"/>
                                   
                                    <xsl:variable name="controlX1" select="($x0 + $x1) div 2"/>
                                    <xsl:variable name="controlY1" select="($y0 + $y1 - 80) - $offsetSpace"/>

                                    <!-- Sposta gli estremi della curva sopra la nota -->
                                    <xsl:variable name="x0Offset" select="($x0 + 2)"/> <!-- Spostamento in orizzontale del punto iniziale della curva -->
                                    <xsl:variable name="y0Offset" select="($y0 - $offsetSpace*2)"/> <!-- Spostamento in verticale del punto iniziale della curva -->
            
                                    <xsl:variable name="x1Offset" select="($x1 + 5)"/> <!-- Spostamento in orizzontale del punto finale della curva -->
                                    <xsl:variable name="y1Offset" select="($y1 - $offsetSpace*2)"/> <!-- Spostamento in verticale del punto finale della curva -->
            
                                    <!-- Disegna la legatura con una curva sopra le note -->
                                    <path d="M{$x0Offset},{$y0Offset} C{$controlX0},{$controlY0 - 10} {$controlX1},{$controlY1} {$x1Offset},{$y1Offset}" 
                                        fill="transparent" stroke="black" stroke-width="2"/>

                                  </xsl:for-each>
                                  <xsl:choose>
                                     <xsl:when test="not(following::mei:note[@tie='t'][1])">
                                          <image preserveAspectRatio="none" href="legatura.png" height="23" width="15"
                                          x="{$x0 - 25}" y="{$yPosition - $flatYOffset}"/>
                                    </xsl:when>
                                  </xsl:choose>       
                                 </xsl:when>                          
                               </xsl:choose>
                               </xsl:if>

                         
                     </xsl:for-each>
             </xsl:when>


                   
  <!-- SINGOLE NOTE  -->
   <xsl:when test="name() eq 'mei:note'">
   <xsl:variable name="noteId" select="mei:note/@xml:id"/>   
   <xsl:message select="$noteId"/>

   <!-- posizione orizzontale della nota -->             
         <xsl:variable name="xPosition">
            <xsl:value-of select="((count(preceding-sibling::mei:note) + count(preceding-sibling::mei:beam/mei:note) + count(preceding-sibling::mei:beam) - count(preceding-sibling::mei:beam[@class='chord'])) * $itemBuffer) + 80"/>
        </xsl:variable>

        <!-- posizione verticale della nota (yPosition) -->
       <xsl:variable name="yPosition">
             <xsl:value-of select="($middleCYPosition + (@oct - 4)*(-35)) - number(translate(@pname, 'cdefgab', '0123456'))*$ledgerBuffer"/>
       </xsl:variable>

         <xsl:variable name="xArray" select="key('xPositionKey', $noteId)/$xPosition"/>
         <xsl:variable name="yArray" select="key('yPositionKey', $noteId)/$yPosition"/>
         

        <!-- lunghezza della stanghetta -->
        <xsl:variable name="stemLength">
           <xsl:if test="number(@oct) le 4">
                <xsl:value-of select="-35"/> 
          </xsl:if>
          <xsl:if test="number(@oct) gt 4">
              <xsl:value-of select="35"/>
          </xsl:if>
        </xsl:variable>

        <!-- offset del gambo in base all'ottava -->
         <xsl:variable name="stemOffset">
            <xsl:if test="number(@oct) le 4">
                <xsl:value-of select="$noteXRadius"/>
           </xsl:if>
            <xsl:if test="number(@oct) gt 4">
                <xsl:value-of select="-$noteXRadius"/>
            </xsl:if>
          </xsl:variable>

    <!-- posizione verticale della nota -->
    <xsl:variable name="yPosition"
        select="($middleCYPosition + (@oct - 4)*(-35)) - number(translate(@pname, 'cdefgab', '0123456'))*5"/>


    <!-- aspetto della testa della nota in base alla durata -->

    <xsl:choose>
        <xsl:when test="number(@dur) ge 4">
            <ellipse cx="{$xPosition}" cy="{$yPosition}" ry="{$noteYRadius}"
                rx="{$noteXRadius}" fill="black"/>
        </xsl:when>
        <xsl:when test="number(@dur) le 2">
            <ellipse cx="{$xPosition}" cy="{$yPosition}" ry="{$noteYRadius}"
                rx="{$noteXRadius}" stroke="black" stroke-width="1.5"
                fill="none"/>
        </xsl:when>
    </xsl:choose>


    <!-- Disegna il gambo della nota -->

    <line x1="{$xPosition + $stemOffset}" x2="{$xPosition + $stemOffset}"
        y1="{$yPosition}" y2="{$yPosition + $stemLength}" stroke="black"
        stroke-width="1.5"/>

    <!-- Aggiunge linee ledger se necessario -->
    <xsl:choose>
        <xsl:when test="$yPosition gt ($middleCYPosition - $lineBuffer*.5)">
            <xsl:for-each select="0 to (($yPosition - $middleCYPosition) idiv $lineBuffer)">
                <line x1="{$xPosition - ($noteXRadius + $ledgerBuffer)}"
                    x2="{$xPosition + $noteXRadius + $ledgerBuffer}"
                    y1="{$middleCYPosition + (position()-1)*$lineBuffer}"
                    y2="{$middleCYPosition + (position()-1)*$lineBuffer}"
                    stroke="black" stroke-width="1.5"/>
            </xsl:for-each>
        </xsl:when>
        <xsl:when test="$yPosition lt ($middleCYPosition - $lineBuffer*5.5)">
            <xsl:for-each select="0 to ((($middleCYPosition - $lineBuffer*6) - $yPosition) idiv $lineBuffer)">
                <line x1="{$xPosition - ($noteXRadius + $ledgerBuffer)}"
                    x2="{$xPosition + $noteXRadius + $ledgerBuffer}"
                    y1="{($middleCYPosition - $lineBuffer*6) - (position()-1)*$lineBuffer}"
                    y2="{($middleCYPosition - $lineBuffer*6) - (position()-1)*$lineBuffer}"
                    stroke="black" stroke-width="1.5"/>
            </xsl:for-each>
        </xsl:when>
    </xsl:choose>

    <!-- Disegna accidental se presente -->
    <xsl:if test="@accid">
        <xsl:choose>
            <xsl:when test="@accid eq 'f'">
             
                <image preserveAspectRatio="none" href="flat.png"
                    height="23" width="15" x="{$xPosition - $flatXOffset}"
                    y="{$yPosition - $flatYOffset}"/>
              
            </xsl:when>
            <xsl:when test="@accid eq 's'">
                   
                <image class="spazi" preserveAspectRatio="none" href="sharp.png"
                    height="22" width="22" x="{$xPosition - $sharpXOffset}"
                    y="{$yPosition - $sharpYOffset}"/>
      
            </xsl:when>
            <xsl:when test="@accid eq 'n'">
                <image preserveAspectRatio="none" href="natural.png"
                    height="23" width="15" x="{$xPosition - $noteXRadius*2 - 6}"
                    y="{$yPosition - $noteYRadius - 9}"/>
            </xsl:when>
        </xsl:choose>
    </xsl:if>

   <!--Posizione le sillabe del verso poetico sotto le note corrispondenti, usando un metodo simile al
    posizionamento delle immagini relative ai valorid dell'attributo @accid-->
              <xsl:choose>
                 <xsl:when test="mei:verse/mei:syl">                    
                   <xsl:if test="mei:verse/mei:syl[@con='s']">                  
                            <text x="{$xPosition - 5}" y="{115}" font-size="15" fill="black">
                                      <xsl:value-of select="."/>  
                                         </text>
                            </xsl:if> 
                            <xsl:if test="mei:verse/mei:syl[@con='d']">                  
                                       <text x="{$xPosition - 5}" y="{115}" font-size="15" fill="black">
                                          <xsl:value-of select="."/> &#45;  
                            </text>                            
                    </xsl:if>
                   </xsl:when>
             </xsl:choose>

    <!--Posizione di eventuali legature @tie-->


     <xsl:if test="@tie">

      <xsl:choose>
        <!-- Se il tie è 'i', salva i valori di posizione -->
        <xsl:when test="@tie eq 'i'">
            <xsl:variable name="x0" select="$xPosition + $stemOffset"/>
            <xsl:variable name="y0" select="$yPosition"/>
            <!-- Spazio sopra la nota per la curva -->
            <xsl:variable name="offsetSpace" select="10"/>
           
            <xsl:message select="concat('Salvati Xpos: ', $x0, ' Ypos: ', $y0)"/>

          <xsl:for-each select="following-sibling::mei:note[@tie='t']">

            <xsl:variable name="x1" select="((count(preceding-sibling::mei:note) + count(preceding-sibling::mei:beam/mei:note)) * $itemBuffer) + $noteXStart"/>
            <xsl:variable name="y1" select="($middleCYPosition + (@oct - 4)*(-35)) - number(translate(@pname, 'cdefgab', '0123456'))*$ledgerBuffer"/>
            <!-- Valori per una curva più morbida -->
             <!-- Punti di controllo per una curva più dolce sopra le note -->
            <xsl:variable name="controlX0" select="($x0 + $x1) div 2"/>
            <xsl:variable name="controlY0" select="($y0 + $y1) div 2"/>
           
            <xsl:variable name="controlX1" select="($x0 + $x1) div 2"/>
            <xsl:variable name="controlY1" select="($y0 + $y1 - 80) - $offsetSpace"/>

            <!-- Sposta gli estremi della curva sopra la nota -->
            <xsl:variable name="x0Offset" select="($x0 + 2)"/> <!-- Spostamento in orizzontale del punto iniziale della curva -->
            <xsl:variable name="y0Offset" select="($y0 - $offsetSpace)"/> <!-- Spostamento in verticale del punto iniziale della curva -->
            
            <xsl:variable name="x1Offset" select="($x1 + 2)"/> <!-- Spostamento in orizzontale del punto finale della curva -->
            <xsl:variable name="y1Offset" select="($y1 - $offsetSpace)"/> <!-- Spostamento in verticale del punto finale della curva -->
            
            <!-- Disegna la legatura con una curva sopra le note -->
            <path d="M{$x0Offset},{$y0Offset} C{$controlX0},{$controlY0 - 10} {$controlX1},{$controlY1} {$x1Offset},{$y1Offset}" 
                fill="transparent" stroke="black" stroke-width="2"/>
      

        </xsl:for-each>
        <xsl:choose>
           <xsl:when test="not(following-sibling::mei:note[@tie='t'][1])">
                <image preserveAspectRatio="none" href="legatura.png" height="23" width="15"
                  x="{$x0 - 30}" y="{$yPosition - $flatYOffset +15}"/>
             </xsl:when>
        </xsl:choose>
       
        </xsl:when>       
      </xsl:choose>
    </xsl:if>

<!--Gestione eventuali harm -->
          <xsl:if test="preceding-sibling::mei:harm">
            <xsl:message select="'ok'"/>

            <!-- Elemento di testo con valore -->
              <text x="{$xPosition - 10}" y="{20}">
             <xsl:value-of select="preceding-sibling::mei:harm/mei:fb/mei:f"/>
            </text>
  </xsl:if>
    </xsl:when>
  </xsl:choose>
</xsl:for-each>
</svg>

</xsl:template>


 <!--INTEGRAZIONI MUSICALI: TAVOLA FONETICA--> 
  <xsl:template match="mei:verse[@type='tf']">
   
        
        <svg width="600" height="120" xmlns="http://www.w3.org/2000/svg">
         
          <!-- Definiamo le coordinate per le sillabe -->
          <xsl:variable name="iX" select="100"/>
          <xsl:variable name="iY" select="100"/>
          
          <xsl:variable name="tX" select="300"/>
          <xsl:variable name="tY" select="100"/>
          
          <!-- Calcola le coordinate per ogni sillaba m -->
          <xsl:variable name="mX" select="150"/>
          <xsl:variable name="mY" select="100"/>
          
          <!-- DisegnA le frecce da i a m, poi da m a t -->
          <xsl:variable name="ms" select="mei:syl[@wordpos='m']"/>
        
          
          <!-- Gestisci il caso con più sillabe m -->
          <xsl:for-each select="mei:syl[@wordpos='m']">
    <!-- Calcola il progresso per ogni m -->
    <xsl:variable name="xprog" select="((position() - 1) * 50) + count(preceding-sibling::mei:syl)" />
    <xsl:variable name="currentM" select="." />
    <xsl:variable name="prevM" select="preceding-sibling::mei:syl[@wordpos='m'][1]" />
    
    <!-- Se è la prima sillaba m: freccia da i a m -->
    <xsl:choose>
        <xsl:when test="position() = 1 and position() != last()">
        <xsl:message>seconda condizione</xsl:message>
        <xsl:variable name="xprog" select="((position() - 1) * 50) + count(preceding-sibling::mei:syl)" />
            <line class="tenut" x1="{ $iX - 50}" y1="{ $iY }" x2="{ $mX - $xprog}" y2="{ $mY }" stroke="black" stroke-width="2"/>
            <polygon points=" 
                { $mX + $xprog },{ $mY } 
                { $mX + $xprog -5},{ $mY - 5 } 
                { $mX + $xprog +5},{ $mY - 5 } "
                fill="black"
                transform="rotate(-90, { $mX + $xprog }, { $mY })"/>

            <text class="iniz" x="{ $iX - 50 }" y="{ $iY - 10 }" font-size="16" text-anchor="middle">
                <xsl:value-of select="preceding-sibling::mei:syl[@wordpos='i']"/>
            </text>

            <text x="{  $mX + $xprog}" y="{ $mY - 10 }" font-size="16" text-anchor="middle">
                <xsl:value-of select="."/>
            </text>
       
        </xsl:when>

        <!--nel caso di una ultima syl media, in una serie di syl medie precedenti-->
         <xsl:when test="position() != 1 and position() = last() and preceding-sibling::mei:syl[@wordpos='m']">
          <xsl:message>terzultima condizione</xsl:message>
           <xsl:variable name="xprog" select="((position() - 1) * 50) + count(preceding-sibling::mei:syl)" />
           <xsl:variable name="prevMX" select="($mX - $xprog)" />
            <line class="tenut" x1="{ $prevMX }" y1="{ $mY }" x2="{ $mX + $xprog }" y2="{ $mY }" stroke="black" stroke-width="2"/>
            <line class="tenut" x1="{ $mX+ $xprog}" y1="{ $mY }" x2="{ $tX}" y2="{ $mY }" stroke="black" stroke-width="2"/>
            <polygon points=" 
                { $mX + $xprog },{ $mY } 
                { $mX + $xprog -5},{ $mY - 5 } 
                { $mX + $xprog +5},{ $mY - 5 } "
                fill="black"
                transform="rotate(-90, { $mX + $xprog }, { $mY })"/>

                <polygon points=" 
                    { $tX },{ $tY } 
                    { $tX - 5 },{ $tY - 5 } 
                    { $tX + 5 },{ $tY - 5 } "
                fill="black"
                transform="rotate(-90, { $tX }, { $tY })"/>


      
            <text x="{ $mX+ $xprog}" y="{ $mY - 10}" font-size="16" text-anchor="middle">
                <xsl:value-of select="."/>
            </text>
            <text class="ferm" x="{ $tX +10}" y="{ $iY - 10}" font-size="16" text-anchor="middle">
                <xsl:value-of select="following-sibling::mei:syl[@wordpos='t']"/>
            </text>
        </xsl:when>

        <xsl:when test="(position() = 1 and position() = last() and not(preceding-sibling::mei:syl[@wordpos='m']))">
        <xsl:message>penultima condizione</xsl:message>
        <xsl:variable name="xprog" select="((position() - 1) * 50) + count(preceding-sibling::mei:syl)" />
            <line class="tenut" x1="{ $iX}" y1="{ $iY }" x2="{ $mX + $xprog}" y2="{ $mY }" stroke="black" stroke-width="2"/>
            <line class="tenut" x1="{ $mX + $xprog }" y1="{ $mY }" x2="{$tX}" y2="{ $tY }" stroke="black" stroke-width="2"/>
            <polygon points=" 
                { $mX + $xprog },{ $mY } 
                { $mX + $xprog -5},{ $mY - 5 } 
                { $mX + $xprog +5},{ $mY - 5 } "
                fill="black"
                transform="rotate(-90, { $mX + $xprog }, { $mY })"/>
            <polygon points=" 
                { $tX },{ $tY } 
                { $tX + $xprog -5},{ $tY - 5 } 
                { $tX + $xprog +5},{ $tY - 5 } "
                fill="black"
                transform="rotate(-90, { $tX }, { $tY })"/>

            <text class="iniz" x="{ $iX -20}" y="{ $iY - 10}" font-size="16" text-anchor="middle">
                <xsl:value-of select="preceding-sibling::mei:syl[@wordpos='i'][1]"/>
            </text>
            <text x="{ $mX + $xprog}" y="{ $mY - 10 }" font-size="16" text-anchor="middle">
                <xsl:value-of select="."/>
            </text>
            <text class="ferm" x="{ $tX +20}" y="{ $tY - 10 }" font-size="16" text-anchor="middle">
                <xsl:value-of select="following-sibling::mei:syl[@wordpos='t']"/>
            </text>
        </xsl:when>

        <xsl:otherwise>
           <xsl:if test="following-sibling::mei:syl[@wordpos='m'] and preceding-sibling::mei:syl[@wordpos='m']">
           <xsl:message>ok ultima condizione</xsl:message>
              <xsl:variable name="xprog" select="((position() - 1) * 50) + count(preceding-sibling::mei:syl)" />
            <!-- Traccia la freccia tra sillabe m -->
            <xsl:variable name="prevMX" select="($mX - $xprog)" />
            <line class="tenut" x1="{ $prevMX }" y1="{ $mY }" x2="{ $mX + $xprog}" y2="{ $mY }" stroke="black" stroke-width="2"/>
            <polygon points=" 
                { $mX + $xprog },{ $mY } 
                { $mX + $xprog -5},{ $mY - 5 } 
                { $mX + $xprog +5},{ $mY - 5 } "
                fill="black"
                transform="rotate(-90, { $mX + $xprog }, { $mY })"/>
            
            <text x="{ $prevMX + 52}" y="{ $mY - 10 }" font-size="16" text-anchor="middle">
                <xsl:value-of select="preceding-sibling::mei:syl[@wordpos='m']"/>
            </text>
        
            <text x="{ $mX + $xprog +5}" y="{ $mY - 10}" font-size="16" text-anchor="middle">
                <xsl:value-of select="."/>
            </text>
           </xsl:if>       
        </xsl:otherwise>
    </xsl:choose>
</xsl:for-each>

    <xsl:for-each select="mei:syl[@type='lunga']">
        <line class="tenut" x1="{ $mX -10}" y1="{ $mY }" x2="{ $iX}" y2="{ $iY }" stroke="black" stroke-width="2"/>
        <line class="tenut" x1="{ $mX +10}" y1="{ $mY }" x2="{ $tX}" y2="{ $tY }" stroke="black" stroke-width="2"/>

        <polygon points=" 
                { $iX },{ $mY } 
                { $iX -5},{ $mY - 5 } 
                { $iX  +5},{ $mY - 5 } "
                fill="black"
                transform="rotate(90, { $iX }, { $mY })"/>

                <polygon points=" 
                { $tX },{ $mY } 
                { $tX -5},{ $mY - 5 } 
                { $tX  +5},{ $mY - 5 } "
                fill="black"
                transform="rotate(-90, { $tX }, { $mY })"/>

        <text class="iniz" x="{ $mX }" y="{ $mY }" font-size="16" text-anchor="middle"><xsl:value-of select="."/></text>
    </xsl:for-each>

    <xsl:for-each select="mei:syl[@wordpos='i']">
      <xsl:if test="not(following-sibling::mei:syl[@wordpos='m'])">

         <line class="tenut" x1="{ $mX +10}" y1="{ $mY }" x2="{ $tX}" y2="{ $tY }" stroke="black" stroke-width="2"/>


                <polygon points=" 
                { $tX },{ $mY } 
                { $tX -5},{ $mY - 5 } 
                { $tX  +5},{ $mY - 5 } "
                fill="black"
                transform="rotate(-90, { $tX }, { $mY })"/>

        <text class="iniz" x="{ $mX }" y="{ $mY }" font-size="16" text-anchor="middle"><xsl:value-of select="."/></text>
         <text class="ferm" x="{ $tX +10 }" y="{ $tY }" font-size="16" text-anchor="middle"><xsl:value-of select="following-sibling::mei:syl[@wordpos='t']"/></text>

      </xsl:if>
        
       
    </xsl:for-each>
          
        </svg>
  
  </xsl:template>
  


      
</xsl:stylesheet>