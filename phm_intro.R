library(shiny)
library(shiny.tailwind)

ui <- div( 

  id = 'toplevel', #class = 'screen-h',
  #includeCSS('./www/styles.css'),
  
  HTML('<html data-theme="synthwave"></html>'),
  tags$script(src = "https://cdn.tailwindcss.com"),
  includeScript(path = './www/js/script.js'),
    includeScript(path = './www/js/listen.js'),
  includeScript(path = './www/js/tt.js'),

  includeCSS(path = './www/custom.css'),
  
    tags$head(tags$link(rel = "stylesheet",
                      type = "text/css",
                      href = 'https://cdn.jsdelivr.net/npm/daisyui@2.17.0/dist/full.css')),
  
  #   twTabNav(
  #    
  #   div(icon("database"), span("Tab One", class = "pl-2")),
  #   div(icon("server"), span("Tab Two", class = "pl-2")),
  #   container_class = "h-full pt-10 pt-2 bg-indigo-900 flex",
  #   tab_class = "cursor-pointer py-2 px-4 my-4 w-full text-white hover:bg-indigo-700"
  # ),
  
  HTML('<div class="navbar bg-base-100">
  
  <div class="navbar-start">
    <div class="dropdown">
      <div tabindex="1" role="button" class="btn btn-ghost bg-transparent lg:hidden">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h8m-8 6h16" /></svg>
      </div>
      <ul tabindex="0" class="menu menu-sm dropdown-content mt-3 z-[1] p-2 shadow bg-base-100 rounded-box w-52">
        <li><a onclick=opentab("page1")>Home</a></li>
        <li><a onclick=opentab("page2")>Content TBD</a></li>
      </ul>
    </div>
    <a href = "https://www.publichealth.hscni.net" class="btn btn-ghost text-xl">Public Health Agency</a>
  </div>
  

  
  <div class="navbar-center hidden lg:flex">
    <ul class="menu menu-horizontal px-1">
      <li><a onclick=opentab("page1")>Intro</a></li>
      <li><a onclick=opentab("page2")>Home Content TBD</a></li>
    </ul>
  </div>
  <div class="navbar-end">
    <button id = "theme" onClick=handleClick() class="btn btn-ghost">toggle mode</button>
  </div>
  

</div>'),
  
   
      div(id='page1', class='nav-content',
  
  div( id = 'h',
  h1('Population Health Model'),
  h4('Coming soon ...')
  ) 
   
     ),
#   src="data:image/png;base64,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"
#border-2 border-rose-500
  div(id='page2', class='nav-content hidden' ,
      
      # div(id = 'par', class='h-screen background-white',
      # HTML('<img h-40 p-2 bg-neutral id=shine src="https://seeklogo.com/images/H/hsc-public-health-agency-logo-E4CF7B4D14-seeklogo.com.png" />')
      # )
      ),
      # 
#       HTML('<div class="tooltip tooltip-top" data-tip="hello">
#   <button class="btn ">Hover me</button>
# </div>
#            
#            <div class="skeleton w-32 h-32"></div>'),
# 
# HTML('<div class="flex space-x-4">
#   <!-- Skeleton for image -->
#   <div class="w-24 h-24 bg-gray-300 rounded-full skeleton"></div>
#   
#   <!-- Skeleton for text -->
#   <div class="flex-1 space-y-4 py-1">
#     <div class="h-4 bg-gray-300 rounded skeleton"></div>
#     <div class="space-y-2">
#       <div class="h-4 bg-gray-300 rounded skeleton"></div>
#       <div class="h-4 bg-gray-300 rounded skeleton"></div>
#     </div>
#   </div>
# </div>'),
   

# 
# 
# 
# 
#     div(
#       h1("First Tab",
#         class = "p-10 text-center font-sans text-8xl font-extrabold text-slate-800"
#       ),
#       plotOutput("plot1")
#     ),
#     div(
#       h1("Second Tab",
#         class = "p-10 text-center font-sans text-8xl font-extrabold text-slate-800"
#       ),
#       plotOutput("plot2")
#     ),
#     container_class = "flex-1 bg-indigo-50"
#   )

HTML('<footer class="text-xs bg-neutral bg-footer absolute min-w-full bottom-10 b flex justify-around p-4 items-center text-neutral-content">
  <span><h5 class="inline"> Contact 
    </h5>
    <svg  class="inline fill-current" width="26" height="16" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" fill-rule="evenodd" clip-rule="evenodd" class="fill-current"><path d="M22.672 15.226l-2.432.811.841 2.515c.33 1.019-.209 2.127-1.23 2.456-1.15.325-2.148-.321-2.463-1.226l-.84-2.518-5.013 1.677.84 2.517c.391 1.203-.434 2.542-1.831 2.542-.88 0-1.601-.564-1.86-1.314l-.842-2.516-2.431.809c-1.135.328-2.145-.317-2.463-1.229-.329-1.018.211-2.127 1.231-2.456l2.432-.809-1.621-4.823-2.432.808c-1.355.384-2.558-.59-2.558-1.839 0-.817.509-1.582 1.327-1.846l2.433-.809-.842-2.515c-.33-1.02.211-2.129 1.232-2.458 1.02-.329 2.13.209 2.461 1.229l.842 2.515 5.011-1.677-.839-2.517c-.403-1.238.484-2.553 1.843-2.553.819 0 1.585.509 1.85 1.326l.841 2.517 2.431-.81c1.02-.33 2.131.211 2.461 1.229.332 1.018-.21 2.126-1.23 2.456l-2.433.809 1.622 4.823 2.433-.809c1.242-.401 2.557.484 2.557 1.838 0 .819-.51 1.583-1.328 1.847m-8.992-6.428l-5.01 1.675 1.619 4.828 5.011-1.674-1.62-4.829z"></path></svg> 
    </span>
    <aside class="inline items-center flex">
    
    <p class = "px-3" ><a class = "bg-link bg-link-primary" href="mailto:aaron.gorman@hscni.net">Developer</a></p>
    <p class = "px-3" ><a href="mailto:catherine.millman@hscni.net">Business Owner</a></p>
  </aside> 
  <nav class="text-xs flex align-content-center flex-direction-row gap-5">
    <a href = "https://www.youtube.com/user/PublicHealthAgency" ><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" class="fill-current"><path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z"></path></svg>
    </a>
    <a href="https://twitter.com/publichealthni" ><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" class="fill-current"><path d="M19.615 3.184c-3.604-.246-11.631-.245-15.23 0-3.897.266-4.356 2.62-4.385 8.816.029 6.185.484 8.549 4.385 8.816 3.6.245 11.626.246 15.23 0 3.897-.266 4.356-2.62 4.385-8.816-.029-6.185-.484-8.549-4.385-8.816zm-10.615 12.816v-8l8 3.993-8 4.007z"></path></svg></a>
    <a href="https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwit8-PXycqFAxUYUUEAHV5iBgEQFnoECBQQAQ&url=https%3A%2F%2Fwww.facebook.com%2Fpublichealthagency%2F%3Flocale%3Den_GB&usg=AOvVaw1-G19Rh1AToraOqPSISCqH&opi=89978449"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" class="fill-current"><path d="M9 8h-3v4h3v12h5v-12h3.642l.358-4h-4v-1.667c0-.955.192-1.333 1.115-1.333h2.885v-5h-3.808c-3.596 0-5.192 1.583-5.192 4.615v3.385z"></path></svg></a>
  </nav>
</footer>
     <footer class="glass-blur-10 glass-opacity-50  absolute min-w-full bottom-0 text-xs bg-footer bg-footer-center text-center p-4 bg-base-200 text-base-content">
  <aside>
    <p>Copyright © 2024 - All right reserved by Public Health Agency Ltd</p>
  </aside>
</footer>'
     )
)

server <- function(input, output, session) {
   
}

shinyApp(ui, server)
