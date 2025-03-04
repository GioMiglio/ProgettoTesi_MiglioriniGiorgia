$(document).ready(function() {
    $('.correzioni').hide();
    $display=false;
    $('.correzioni_manoscritte').hide();
    $display_2=false;
    $('.espansioni').hide();
    $display_3=false;
 



//visibilità del menù di frontpage
    $('h2').click(function() {
        // Mostra il div #nav aggiungendo la classe "show" per attivare l'animazione
       
            $('#nav').addClass('show');
            $('#frontpage h2').hide(); 
      
    });

    $('#nav h3').click(function(){
        $('#nav').removeClass('show');
        $('#frontpage h2').show(); 
    });

    $('#bottoni h2').click(function(){
        $('#bottoni ').removeClass('visible');
    
    });

    
//visibiltà della barra contenente i fenomeni notevoli
    $(window).scroll(function() {
        // posizione corrente dello scroll
        var scrollTop = $(window).scrollTop();
       
        
        if (scrollTop > 6500) {
         
          $('#bottoni').addClass('visible');  
        } else {
          
          $('#bottoni').removeClass('visible');  
        }
      });
    
//gestione delle note testuali aggiunte al testo
    $('a.popup-trigger').click(function(event) {
        event.preventDefault();
        console.log('Popup Trigger Clicked');  // Verifica se viene cliccato
        
        var anaValue = $(this).attr('id'); 
        var spanId = 'popup_' + anaValue;
        console.log('Span ID:', spanId);  // Verifica l'ID del popup
        
        var $popup = $('#' + spanId);
        console.log('Popup:', $popup);  // Verifica che il popup venga selezionato correttamente
        
        if ($popup.hasClass('open')) {
            $popup.removeClass('open').addClass('close').hide();
        } else {
            $('.popup').each(function() {
                if ($(this).hasClass('open')) {
                    $(this).removeClass('open').addClass('close').hide();
                }
            });
            $popup.removeClass('close').addClass('open').show();
        }
    });
    

//gestione fenomeni notevoli   
    $("#bottoni button").click(function() {
        console.log('ok');
    
        var $id_bottone = $(this).attr('id');
        var $colore_bott = $(this).attr('class'); // La classe, che assume il ruolo del colore
        var $button = $("." + $id_bottone); 

        var currentColor = $button.css('color'); 
        var current_Color = $button.css('stroke'); 
        console.log(current_Color);

        // Verifica se il colore del testo è nero (rgb(0, 0, 0) o "black")
        if (currentColor === "rgb(0, 0, 0)" || currentColor === "black" || current_Color === "rgb(0, 0, 0)") {
             if ($(this).is("#bottoni button#tenut") || $(this).is("#bottoni button#ferm") || $(this).is("#bottoni button#iniz")) {
                $button.css('stroke', "red"); 
                $button.css('color', $colore_bott); 
            } else {
            $button.css('color', $colore_bott); // Imposta il colore del testo sulla classe
            $button.css('background-color', 'lightgrey'); //colore di etichetta, per contrasto
            $button.css('font-weight', 'bold'); // Imposta il testo in grassetto
             
            }
           
        } else {
            $button.css('stroke', 'rgb(0, 0, 0)'); 
            $button.css('color', 'black'); 
            $button.css('background-color', 'transparent');
            $button.css('font-weight', 'normal');        
            
        }
    });



    //mostra e nasconde correzioni, al clic sul bottone addetto
    $("button#sic").click(function() {
        if ($display==false){
            $('.correzioni').show();
            $display=true;
        }else{
            $('.correzioni').hide();
            $display=false;
        }
    });

  //mostra e nasconde correzioni manoscritte, al clic sul bottone addetto
    $("button#manoscritte").click(function(){
        if ($display_2==false){
            $('.correzioni_manoscritte').show();
            $display_2=true;
        }else{
            $('.correzioni_manoscritte').hide();
            $display_2=false;
        }

    });

     //mostra e nasconde abbreviazioni ed espansioni, al clic sul bottone addetto
    $("button#abbr").click(function(){
        if ($display_3==false){
            $('.espansioni').show();
            $display_3=true;
        }else{
            $('.espansioni').hide();
            $display_3=false;
        }

    });
    
    
    
});
