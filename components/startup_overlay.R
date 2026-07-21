library(shiny)
button_block <- function(border = 'red',...){
  
  l <-  list(...)
  # print(class(l))
  # print(class(l[[1]]))
  div(
    
    
    div(class='divcontainer',
        style =paste0('padding:20px;
   display:flex;
   flex-direction:row;
   justify-content:space-between;
   flex-wrap:wrap;
   margin:15px;
   border: solid ',border,' 2px;
   border-radius: 50px;
   
    -webkit-box-shadow: 7px 16px 0px 1px ',border,';
    -moz-box-shadow: 7px 16px 0px 1px ',border,';
    box-shadow:  7px 16px 0px 1px ',border,';'),
        
        #tagList(l),
        as.tags(l)
        
    )
  )
}

startup_overlay_div <- function(overlay_out_time_ms = 500, main_in_time_ms=700){
  
  tags$div(id = "startup-overlay", 
           
           # tags$head(tags$link( rel='stylesheet', href='/css/progress_bar.css')),
           
           tags$script(HTML(paste0("
    setTimeout(function() {
      //document.getElementById('startup-overlay').style.display = 'none';
      // document.getElementById('main-content').style.display = 'block';
        $('#startup-overlay').fadeOut(500);

        //$('#main-content').fadeIn('slow');

    }, ",overlay_out_time_ms,");  // 10 seconds = 10000 ms
    //5000
    setTimeout(function() {
      //document.getElementById('startup-overlay').style.display = 'none';
      // document.getElementById('main-content').style.display = 'block';
       // $('#startup-overlay').fadeOut(200);
       
        $('#toplevel').fadeIn('slow');

    }, ",main_in_time_ms,");  // 10 seconds = 10000 ms
    //7000
  "))),

           style = "
    position: fixed;
    top: 0%; /* 1% 110px*/
    left: 0%;
    width: 100%;
    height: 100%;
   
    color:  white; /* rgb(122,236,244); rgb(30,30,30); */
    text-align: center;

    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 10040;
  ", div(style = 'overflow:hidden; background-color:black;margin:0px;border-radius:1px;height:100%;width:100%;display:flex;justify-content:space-around;align-items:center;flex-direction:column;',

         #button_block(border = 'white',

        h1(id='overlay_hero','Population Health Model'), #class = 'text-xl'
        h1(class = 'text-white text-xl', 'Risk Registry'), #
        
         div(info_value_box('white')),
         
         #),
         #div(style='display:block;position:absolute;justify-content:start;top:50px;left:50px;gap:20px;',
         #img(style= '',src = 'img/pha_logo_0.png', width = '120px;'),
         #p(style='font-size: 11px;','Population Health Model')
         #),
#          HTML('<div class="loader-container1">
#     <div class="progress-bar1">
#         <div class="progress1"></div>
#     </div>
# </div>' ),
         
         HTML('<div class="flex justify-center items-center w-[200px] mt-8">
  <div class="relative w-[70%] max-w-[500px] h-3 bg-black border border-black rounded-lg overflow-hidden">
    <div class="absolute top-0 left-0 h-full bg-white animate-[fill1_2s_ease-in-out_3s_forwards]"></div>
  </div>
</div>

<head> <style>
@keyframes fill1 {
  0% { width: 0%; }
  90% { width: 100%; }
  100% { width: 100%; }
}
</style></head>'))
  )
  

  }

fluidPage(startup_overlay_div()) |> htmltools::browsable()

