###### Link here ##########

#https://aarong1.shinyapps.io/PHMRiskRegistry/

###########################

library(shiny)
# library(shiny.tailwind)
library(DT)
library(apexcharter)

source('./components/infographics_value_box.R')
source('./components/startup_overlay.R')



addResourcePath("text", "www")
#https://shiny.posit.co/r/reference/shiny/1.7.0/resourcepaths.html

ui <- div( 
  startup_overlay_div(6000,8000),
  
  div( id = 'toplevel', style = 'display:none;', class = 'pb-32', # Add bottom padding for footer space
  #includeCSS('./www/styles.css'),
  
  # HTML('<html data-theme="synthwave"></html>'),
  HTML('<html data-theme="black"></html>'),
  HTML('<link rel = "application/json" href = "writelines_rr_json.json">'),
  HTML('<link href="https://cdn.jsdelivr.net/npm/daisyui@latest/dist/full.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@latest/dist/tailwind.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/gridjs/dist/gridjs.production.min.js"></script>'),
  tags$script(src = "https://cdn.tailwindcss.com"),
  includeScript(path = './www/js/script.js'),
    includeScript(path = './www/js/listen.js'),
  includeScript(path = './www/js/tt.js'),

  includeCSS(path = './www/custom.css'),
  
    tags$head(tags$link(rel = "stylesheet",
                      type = "text/css",
                      href = 'https://cdn.jsdelivr.net/npm/daisyui@2.17.0/dist/full.css'),

  ),
  
  #   twTabNav(
  
  #   div(icon("database"), span("Tab One", class = "pl-2")),
  #   div(icon("server"), span("Tab Two", class = "pl-2")),
  #   container_class = "h-full pt-10 pt-2 bg-indigo-900 flex",
  #   tab_class = "cursor-pointer py-2 px-4 my-4 w-full text-white hover:bg-indigo-700"
  
  # ),
  
  tags$head(
    tags$style(HTML("
      /* Panel styles */
      
      #slidePanel {
        position: fixed;
        top: 0;
        right: -300px; /* Start offscreen */
        width: 300px;
        height: 100%;
        /*background-color: #f8f9fa; */
        box-shadow: -2px 0 5px rgba(0,0,0,0.3);
        transition: right 0.3s ease;
        padding: 20px;
        z-index: 1000;
      }

      /* Show the panel */
      #slidePanel.open {
        right: 0;
      }

      #toggleBtn {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 1100;
      }
      
      input[type = 'search']{
  width:100%
  };
  
    ")
    )
  ),
  
  actionButton(icon('right-from-bracket'), 
               label = NULL, 
               class = "btn btn-secondary", #"btn-outline-info", 
               style = 'transform: rotate(180deg);position:absolute;bottom:75px;right:15px;',
               inputId =   "toggle_open"),



## Slide In panel -----

  tags$div(class = "bg-base-200 text-base-content", #'display:relative;',
    id = "slidePanel",
    h4("Collect Graphics from your Report"),
    
    p(class ='fs-5',  #text-muted 
      icon('indent',class='fs-6 ml-4',
                                     `data-bs-container` = "body",
                                     `data-bs-toggle` = "popover",
                                     `data-bs-placement` = "left",
                                     `data-bs-content` = "You can collate the visuals you see on the dashboard on this page  ",
                                     `data-bs-original-title` = "How do you use this?"),
      "Plot Repository"
    ),
    
    div(id = 'editor', class = 'bg-accent-content/10 shadow-sm', style = 'height:80%;',
        br(),
        p(class ='text-muted','Hello !'),
        p(class ='text-muted','Drag and drop plots here (Edit me!) '),
        tags$br()
    ),
    
    actionButton(
      icon('right-from-bracket'), 
      label = NULL, 
      class = "btn btn-info", #"btn-info", 
      style = 'transform: rotate(0deg);position:absolute;bottom:20px;right:15px;',
      inputId =   "toggle_close"),
    
    # actionButton("closePanel", "Close")
    div( class="btn-group", role="group", `aria-label`="Basic example",style = 'position:absolute;bottom:20px;left:15px;',
         actionButton(
           icon('floppy-disk'), 
           label = 'Save' , 
           class = "btn-info", 
           style = '',
           inputId =   "save"),
         
         actionButton(
           icon('copy'), 
           label = 'Copy' , 
           class = "btn-info", 
           style = '',
           inputId =   "copy_paste")
    ), 
    
    #     HTML('<div class="btn-group" role="group" aria-label="Basic example">
    #   <button type="button" class="btn btn-secondary">Copy</button>
    #   <button type="button" class="btn btn-secondary">Save</button>
    # </div>')
    
  ),
  tags$script(HTML("
  document.addEventListener('DOMContentLoaded',function(){
    document.getElementById('toggle_open').onclick = function() {
      document.getElementById('slidePanel').classList.toggle('open');
    };
    document.getElementById('toggle_close').onclick = function() {
      document.getElementById('slidePanel').classList.remove('open');
    };
  });
  ")),
  
  tags$head(
    tags$script(src = "js/make_canvas_elements_draggable.js"),
    tags$script(src = "js/app.js"),
    tags$script(src = "js/clipboard.js"),
    
    HTML('<script src="
https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.min.js
"></script>
<link href="
https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.bubble.min.css
" rel="stylesheet">')
  ),
  
  
  
  HTML('<div class="navbar bg-base-100 shadow shadow-base-100">
  
  <div class="navbar-start">
    <div class="dropdown">
      <div tabindex="1" role="button" class="btn btn-ghost bg-transparent lg:hidden">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h8m-8 6h16" /></svg>
      </div>
      <ul tabindex="0" class="menu menu-sm dropdown-content mt-3 z-[1] p-2 shadow bg-base-100 rounded-box w-52">
        <li><a onclick=opentab("page1")>Home</a></li>
        <li><a onclick=opentab("page2")>Risk matrix</a></li>
        <li><a onclick=opentab("page3")>Disability weights</a></li>
      </ul>
    </div>
    
      <a href = "https://www.publichealth.hscni.net" class="shadow-base-content-100 btn rounded-lg btn-primary text-xl h-70 w-100">
    <img src = "img/phalogo_black_white.png" style = "padding:10px; height:45px;">
      </a>
      
      <p style = "width:10px;"> </p>
      
      <a class="shadow-base-content-100 btn btn-primary rounded-lg" onclick=window.open("https://example.com", "_blank")> 
  <img src = "img/inverse_logo.png" style="height:35px;">
  </a>
      
      <!--
    <a href = "https://www.publichealth.hscni.net" class="btn btn-ghost text-xl">Public Health Agency</a>
      -->
  </div>
  

  
  <div class="navbar-center hidden lg:flex">
    <ul class="menu menu-horizontal px-1">
      <li><a onclick=opentab("page1")>Intro</a></li>
      <li><a onclick=opentab("page2")>Risk matrix</a></li>
      <li><a onclick=opentab("page3")>Disability weights</a></li>
    </ul>
  </div>
  <div class="navbar-end">
  <label class="swap">
  <input  onClick=handleClick() type="checkbox" />
  <!--
  <div class="swap-off">OFF</div> 
  <div class="swap-on">ON</div>
  -->
  <!-- moon icon -->
  <svg
    class="swap-off h-10 w-10 fill-current"
    xmlns="http://www.w3.org/2000/svg"
    viewBox="0 0 24 24">
    <path
      d="M21.64,13a1,1,0,0,0-1.05-.14,8.05,8.05,0,0,1-3.37.73A8.15,8.15,0,0,1,9.08,5.49a8.59,8.59,0,0,1,.25-2A1,1,0,0,0,8,2.36,10.14,10.14,0,1,0,22,14.05,1,1,0,0,0,21.64,13Zm-9.5,6.69A8.14,8.14,0,0,1,7.08,5.22v.27A10.15,10.15,0,0,0,17.22,15.63a9.79,9.79,0,0,0,2.1-.22A8.11,8.11,0,0,1,12.14,19.73Z" />
  </svg>
    <!-- sun icon -->
  <svg
    class="swap-on h-10 w-10 fill-current"
    xmlns="http://www.w3.org/2000/svg"
    viewBox="0 0 24 24">
    <path
      d="M5.64,17l-.71.71a1,1,0,0,0,0,1.41,1,1,0,0,0,1.41,0l.71-.71A1,1,0,0,0,5.64,17ZM5,12a1,1,0,0,0-1-1H3a1,1,0,0,0,0,2H4A1,1,0,0,0,5,12Zm7-7a1,1,0,0,0,1-1V3a1,1,0,0,0-2,0V4A1,1,0,0,0,12,5ZM5.64,7.05a1,1,0,0,0,.7.29,1,1,0,0,0,.71-.29,1,1,0,0,0,0-1.41l-.71-.71A1,1,0,0,0,4.93,6.34Zm12,.29a1,1,0,0,0,.7-.29l.71-.71a1,1,0,1,0-1.41-1.41L17,5.64a1,1,0,0,0,0,1.41A1,1,0,0,0,17.66,7.34ZM21,11H20a1,1,0,0,0,0,2h1a1,1,0,0,0,0-2Zm-9,8a1,1,0,0,0-1,1v1a1,1,0,0,0,2,0V20A1,1,0,0,0,12,19ZM18.36,17A1,1,0,0,0,17,18.36l.71.71a1,1,0,0,0,1.41,0,1,1,0,0,0,0-1.41ZM12,6.5A5.5,5.5,0,1,0,17.5,12,5.51,5.51,0,0,0,12,6.5Zm0,9A3.5,3.5,0,1,1,15.5,12,3.5,3.5,0,0,1,12,15.5Z" />
  </svg>

</label>
  <!--  <button id = "theme" onClick=handleClick() class="btn btn-ghost">toggle mode</button> -->
  </div>
  

</div>'),
  
   
      div(id='page1', class='nav-content',
  
  div( id = 'hero',
  h1('Population Health Model')#,
  #p('Coming soon ...'),
  #HTML('<div class = "btn btn-accent"> See our Risk Matrix </div>')
  ) 
     ),
#   src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAzFBMVEX///8AtMsAAAAArcQAtMwAr8Wr5eih4ObA7vAAtcr9/////v+lpKRUUlMuKyz8/PzZ2Nk8OjtEu8vn5ub4///t7O3Ix8cAqLxEQULAwMBzcnL39/fs///y8vKx5Oh50NvR0dG6uLmwr6+Fg4Tk//+WlZU3MzWNi4xoZmcPCArY+fpfXV4aFRfh4ODNzc2fnp9hxdAfGxzh8vPS7O4Apb18xs4nsMDJ/f2v9fiD4+grvc5JxtNizdWG09pPTE1xcHCp2t592N+GzdTA5+mLNcIQAAALA0lEQVR4nO2aCXeiSBDHoYFEEI+IiGdU1CioUWczzLUmO7vf/zttVTWXRxKSycxk3qvfm4mAgP2nuuvoRlEYhmEYhmEYhmEYhmEYhmEYhmEYhmEYhmEYhmEYhmEYhmEYhmEYhmEYhmEYhmEYhmEYhmEYhmEY5p1QVqxC51nxqVb+yLunbNVqtXLtZVh0SRn//O72F+C1jbR+7PJfBlhCUfrh9UVB/mlO5cYHuPivUh86wfvWiK2bDiPN0Ipx9zGM4MO4+zj92FdKd1GIEp/7FbfuZDu9ev3H2lyv535wXe89fTace+0ZpqkWpPEpMk3dNIZhdHepNBtGoynvQm2/9e2N3XFPfmUjJrkGiir89buD09aM/bi5jt95vM2ByD2vtrh9TmDJK6pOVc3os6eaUqiqby3l0tAulFRiXUgmxz9jHyq8UpSBEPPT5qxE/HRa4v7xRlfzCiti9KTAmtKM1MIGNI0vEZk7+hzh374SenrDyim8cpy1XxUPzypUludaVs0UVp5TuJ71iihEExYWqKpfvxk6CNW+NFRT170Qnw/8zRS28cMNxPpZhcq5wfsChTUhCiq8NIoLBHGqDv+//Y0XmVpJsbaqdp22Vyq0lK7wzyh0625eYcKgvk59xalCt54+LCe+PlEY1BKFtXWu2/6wQsD4W8NP07hUlKFh7I8UKsoEFHbEgrZvsDm2mDttGKDLQaqwIlr49e09Dtx4SFoHCqH3OxX4sopOpzcJYPOqniisBLvdKtjhfeo+fNM+6jWvVigxVKlwT5dv04GYKGxD648ULkTF31TFrpcovCeFthAPtr2wUxvG5hyRDR0h7JG/Qm85EJNxZyJoBKLCWXe16nahZ1SCBzGZXYngjGt+vULsqygUFF5oZuNY4UaslCOFgZjhSW3srTmFIxGM8u2prtqSq6BCTwpttqbz6QfmZG3paYSgSyqrlUOnbt5SoZopvNbULCJCpLP9DfS70bFCCoGoaFfLK1yK2HpxBljdxfFGrCp4u64UkUYHadojT0O3GItlIYW6Koeanu7q9KFnsvTsbFRY0swop3AFjQu6OJiOFMa+dAdeNlPYC8Rh38JxiIm99DSQJ4yBTkXgSHTsRftm1T5VOJLazwfQvMJc0/NHdPP4WHriGYVtp+7IMHBe4RW0J1PoiJ1yUIAd+lJyLkQHvZe47z4EjymsF1B4BAjT9TgZMM145Mn9RDT6UsiIDhSmtz6v8ObAhm7s8R9ROBf2gHBrykxUBuh6fkihaRgGBnITNzBVhfTTixrbRgSJq5Qn9xty3zQuaBx+PaswybuqUqEcUSCpl1NY24nDJPxQoZ/LE2Quuj5QmMbDggq1UrPfl5H8ArYgazG1balpWVZz+l0ejy5D3LeS/RJdfuJLibWgMdYRsS+lps/RsDlP0z1KXQ4VuiIdpj1pMT9TaL3chh60txlRyzFLaZimd5kMETzJ1Ib95Lo9XaSFtHUaD4l2UFm7vsB+CTa8qd7W3BnJzSmE/K4yGgxuR2cVwgOpdgY1tzXCATzDx5V5Gujws4H7QhvmFVoN1aCmT8NpU9nCiNT2uGv1w2m/2ZC5TZ9ymqGSKbzJ7i0LDXuCHXEmWpS7UKUjq6c2Rfx1lQ5342uOa4u5SL4eQQAJhI+RFs5yyJ4CH+i9rJ4OHm5RhWDUsrX3PC+iTrnF4Vbaeneet6VxqEMgtLZ6LmsbHFR17qw7rysjHxpd9wfKeDKxe9lZHV8Guc58MveTznhSHzr2ZLJp4UFn1p05cEJ2Vmsy8fE+7ulPF1U4VZS+h34UBJnYiaFYRr+axA+wcRNMnRaI5bO/8Xs5UeihG40V4jCz9nfSq4I/KYPepJbU43AIT4Ckn62F3gPHCq1/h8hfUiGEO8WCfmnEcpRLLY32pnSlISicxnd6lxwrzACFakRtV6Z7KJJpsmJoJEEfP1EaBotmfKd3yZMKTTUqyXARRtLC24OsB+PgEEZjcqd3yUkvnYYh/GtKG0KMHJbIQiWPYiTaMPUzGCWacV/+cxQ2PeTuOlEIaVvj2rLAepCDlmEcqpmjQc04DEMlm4p6f5wopIFmXEMgbMRJt4p6IXXBzoi+NDahScPwwsAJN+uD9ecozMVDCIPUKcmL7g1ymSXMuU3pbTDj2ao6KG/+80cp1LOs7ftlAzOaKfkYmbqE2wiO/G3IaSiIhhjv+x//oF4aYfWXRPwSZKHTKY6yEqQ2MrIrTUhL8TS06bVGffV6mCl8b3nN2dpCzoCCDafJaSEd9i7SanxrYie15IeyHeYK9d648+jk5W/gwIafwWCy7ruELYiH+7CP1WF4KSf+Ta1RmmJ92A+3iSfFRKDv5WyojMXJnP7v5KDGN6jGp1KetrIKnyY08CsNDsgjUb+s7DUqoC7u8goXu6p4R4Py6dlE8+ATNeKsG87emBjnoUtj1IdYmVM4EMuJkIXMK4fk247kwvOlR6s3MifVMNxDX1VzCsdi08l1Uyc/Jp11bjEz/427Pl1y/MUKv6aTbVIgFU6RjIlDw8wpXIp6D6ebCHsnxK7lS5vaq2RlcRH0cKcdz0JtsM6vOiNchUDpwe6ZVd2foND44pm57qqnJgT3O/XUXC8d4DzGIu6mD2I38xdiSbtdsex0ljTF+BB0RXfeFjRlUWuL3cSeV3tKVV62Sec0fqXC7w1pydiEmjQhrVjsDTOncIwTRmM5VToWVZydmNHsTDx9usTtbkCzRxWy6INYxtdu5CntpxcEX6PQPDPdfaRwT3XTt2/xfkRTUBRBYRTmbbjEmbV4svY+NmUV55wqco6phaq6cjWthZNHa7FK+qScPHTiJY63VPi8DdUhPYfGd4M8KiqDLMfYWmVwpNBtU4WuuHIdZ7AQY5zijBe8KrRCUcUliLGNs4Rd/BrFVbO5YuQBF1Y3jywi/WSFDRCkqxFVTzqaDPsoDkZcI9czhb6QSw2rRc4YqHBNazZCTgDGCumEeU7QLU4htsWbpkRFFUbYGdXok4eVBdZLQ3AzmHrLGitVWBFzG9gEYD4XV9IShY64GjiEe6hwRguLMTvhOI+skv2AwiJvKkDc2xqQe3/CqQ2MgRca9FGo/vdUEkOZUaO8dCACJRY1xolbGQ5ucIViFWQhIK/Qz8/rQw+1xRMv0rxGYfq2yZPOBkqlkmZCsbGX7gWfSkR9lNI56K5SoZ8MKhstMZHmgES1hWMstlX5UOFA5CS5olIJ3jjlIyOSuqctuW02MM6HnhQovU0oOzh216w/xk0FtzgIxLJV3wi0IS7Jz9xyzUFteYUYTGy35tIRyAXOvUf04xIjTX3mtS/oplBIqI3mv2EmEL0NLrhdJBW+I5IXDSBS2LCPr1+I1oJWFkbxAvYA7RkrxEWIZG2C/MutOH4T5w0UQuP6eyjcn3pdz9O8hnUB9T7EQesaTvWwaMIJAC8aguaaRZ10bacdbiQ36+NWD98HwfqxNp535zYK6NBfZWD7lGWvN93urEUPafTGfiaVCIV76Rn+ayohzSw2/4M9fA3qAx4Om8ktHqW3EsXyzPJb5zMp9Ibp8zz2vvPj+mTAn8fL3QXo/qziGd9qfvak0zMseenjBgwWfmu8FEHB0mh0L6pvWFUcg29up69wyz8HG+Vy+i29423J85+6ZW9JLmRRNEfpivufViYeY51sZKX3S0rwQf12dP5lrHPUxy+4NcMwDMMwDMMwDMMwDMMwDMMwDMMwDMMwDMMwDMMwDMMwDMMwDMMwDMMwDMMwDMMwDMMwDMMwDMO8Q/4H2Fj1p1t+I6oAAAAASUVORK5CYII="
#border-2 border-rose-500
  div(id='page2', class='nav-content hidden' ,
      div(style ='height:15px;'),
      
      #This works !!!
      #shiny::tags$input(id='hello', type = 'checkbox'),
      
     HTML(' <div class = "" >
     <fieldset class="fieldset flex flex-row justify-evenly gap-[30px] w-xs bg-base-300 border border-base-300 p-4 rounded-box">
  <legend class="fieldset-legend">Filter Risk</legend>
    
  <div>
  <label class="fieldset-label">Source</label>
        <input class="btn btn-square" type="reset" value="×"/>
        <input id = "gbd" class="btn" type="checkbox" name="frameworks" aria-label="Global Burden Disease"/>
        <input id = "sapm" class="btn" type="checkbox" name="frameworks" aria-label="SAPM"/>
        </form>
       </div> 
        
       <div>
            <label class="fieldset-label">Risk range</label>
          <input id= "risk_range" type="range" min="0" max="10" value="1.5" class="range range-primary" />
            <div class="flex justify-between px-2.5 mt-2 text-xs">
                 <span>0</span>
                 <span>2</span>
                 <span>4</span>
                 <span>6</span>
                 <span>8</span>
                 <span>10</span>
  </div>
          </div>

<div>
  <!-- <label class="fieldset-label">Source</label> -->
  <select id = "age" class="select select-primary">
    <option disabled selected>Pick an Age</option>
<option>All         </option>
<option>All ages    </option>
<option>25-29 years </option>
<option>30-34 years </option>
<option>35-39 years</option>
<option>40-44 years </option>
<option>45-49 years</option>
<option>50-54 years</option>
<option>55-59 years</option>
<option>60-64 years</option>
<option>65-69 years </option>
<option>70-74 years</option>
<option>75-79 years </option>
<option>80-84 years</option>
<option>85-89 years</option>
<option>90-94 years </option>
<option>95+ years</option>
<option>20-24 years </option>
<option>All-age  </option>
<option>15-19 years</option>
<option>7-27 days  </option>
<option>28-364 days</option>
<option>1-4 years  </option>
<option>0-6 days   </option>
    
  </select>
  
  </div>
  
  <div>
  <label class="fieldset-label">Remove baseline RR</label>
  <input id = "baseline_checkbox" type = "checkbox" checked="checked" class="checkbox checkbox-accent"/>
</div>

  <div>
  <!-- <label class="fieldset-label">Sex</label> -->
  <select class="select select-secondary">
    <option disabled selected>Pick a Gender</option>
    <option>Both</option>
    <option> Male </option>
    <option>Female</option>
  </select>
  </div>
  
      </fieldset>
      
</div>'),
     
     tags$button(id='filter_table',class= "btn btn-primary btn-sm p-2 m-2 btn-outline", 'Filter'),
     tags$button(id='reset_table',class= "btn btn-sm p-2 m-2 ", 'Reset'),
     
     # HTML('<div class="badge badge-primary">
     # <a class="link link-seconary">SAPM</a>
     # </div>'),
     
     
 
       #<!-- <label class="fieldset-label">Source</label> -->
     
      #  tags$div(id= 'age1', class="dropdown",
      #  shiny::tags$ul(disabled = TRUE, selected = TRUE, 'Pick an Age'),
      #  shiny::tags$li('All'),
      #  shiny::tags$li('0-5'),
      #  shiny::tags$li('5-15'),
      #  shiny::tags$li('15-25'),
      #  shiny::tags$li('25-35'),
      #  shiny::tags$li('35-45'),
      #  shiny::tags$li('45-55'),
      #  shiny::tags$li('55-65'),
      #  shiny::tags$li('65+ ')
      # ),
     
#####################  #####################

#####################  #####################

#####################  #####################
#      HTML('<div class="dropdown">
#   <div tabindex="0" role="button" class="btn m-1">Click</div>
#   <ul tabindex="0" class="dropdown-content menu bg-base-100 rounded-box z-1 w-52 p-2 shadow-sm">
#     <li><a>Item 1</a></li>
#     <li><a>Item 2</a></li>
#   </ul>
# </div>'),
     
     # 
     # tags$select(id= 'age1', class="select select-primary",
     #             shiny::tags$option(disabled = TRUE, selected = TRUE, 'Pick an Age'),
     #             shiny::tags$option('All'),
     #             shiny::tags$option('0-5'),
     #             shiny::tags$option('5-15'),
     #             shiny::tags$option('15-25'),
     #             shiny::tags$option('25-35'),
     #             shiny::tags$option('35-45'),
     #             shiny::tags$option('45-55'),
     #             shiny::tags$option('55-65'),
     #             shiny::tags$option('65+ ')
     #             
     #             
     # ),

      #DTOutput('relative_risk'),
      #datatable(mtcars),
     
     HTML('<div id="my-table" class="p-4 m-4"></div>
  
<script>

  let originalData = [];
  
  // think this fetches from the www static assets directory by default
  // use absolute path to static asset folder (www) with no prefix
  fetch("json_rr_writelines.json")
    .then(res => res.json())
    .then(data => {
      originalData = data;
      const formatted = formatData(originalData);
      //originalData = formatted ;
      window.originalData = originalData;
    });

  function formatData(data) {
    return data.map(item => [
      item.disease, item.rr, item.Age, item.sex,
      item.category, item.risk, item.outcome, item.source
    ]);
  }
  
  
  let grid = new gridjs.Grid({
     columns: ["disease", "rr", "Age","sex", "category/dose", "risk", "outcome","source"],
     //data: formatData(originalData),
     //     [{disease: "tickles", rr: "3"}] ,
      server: {
          url: "json_rr_writelines.json",
          then: data => data.map(item => [item.disease, item.rr, item.Age, item.sex, item.category, item.risk, item.outcome, item.source])

      },
    pagination: {
      limit: 5
    },
    search: true,
    resizable: false,
    sort: true,
    className: {
      table: "table w-full border border-base-300",
      th: "bg-base-200 text-base-content text-left p-3",
      td: "p-3 border border-base-300",
      paginationButton: "btn btn-sm p-2 m-2 btn-outline",
      search: "input m-3 input-bordered input-sm w-full"
    }
  }).render(document.getElementById("my-table"));
  
  window.grid = grid;
  
  </script>
  
  <script>
// Build URL with query params from filters
  function buildFilteredURL() {
    let age = document.getElementById("age")?.value;
    let gender = document.querySelector("select.select-secondary")?.value;

    let base = "/www/json_rr_writelines.json";
    let params = new URLSearchParams();

    if (age && age !== "Pick an Age") params.append("age", age);
    if (gender && gender !== "Pick a Gender") params.append("sex", gender);

    return `${base}?${params.toString()}`;
  }

  document.getElementById("filter_table").addEventListener("click", function () {
    newData = originalData
    let age = document.getElementById("age")?.value;
    if (age && age !== "Pick an Age") {
      newData = window.newData.filter((row) => {return row.Age === age;})
      console.log(age);
    }

    let gender = document.querySelector("select.select-secondary")?.value;

    if (gender && gender !== "Pick a Gender"){
    console.log(gender);
      newData = newData.filter((row) => {return row.sex === gender;})
    }
    
    let source = null;
    
     if ( Shiny.shinyapp.$inputValues["sapm"] & !Shiny.shinyapp.$inputValues["gbd"]){
        console.log("spam");
        let  source = "SAPM"
        newData = newData.filter((row) => {return row.source === "SAPM";})
     }
  
     if ( Shiny.shinyapp.$inputValues["gbd"] & !Shiny.shinyapp.$inputValues["sapm"]){
        console.log("gbd");
        let  source = "GBD"
        newData = newData.filter((row) => {return row.source === "GBD";})
     }
     
     risk_range = document.getElementById("risk_range")
     risk_range_value = risk_range.value
     newData = newData.filter((row) => {return Number(row.rr) <= risk_range_value ; } )

    //Remove Baseline
    remove_baseline = document.querySelector("#baseline_checkbox")
    remove_baseline_bool = remove_baseline.checked
    
    if (remove_baseline_bool) {
    console.log("remove baseline");
        newData = newData.filter((row) => {return Number(row.rr) != 1 ; } )
    }

    // const sourceRadios = document.querySelectorAll(#source_input input[type="radio"][name="frameworks"]);
    //   let selectedSource = null;
    //   
    //   sourceRadios.forEach(radio => {
    //     if (radio.checked) {
    //       selectedSource = radio.getAttribute("aria-label");
    //     }
    //   });

    console.log(newData)
    
    if (newData.length != originalData.length){
    grid.updateConfig({
      data: formatData(newData),
      server:null
    }).forceRender();
    }
    
  });

  // Reset button reloads all data
  document.getElementById("reset_table").addEventListener("click", function () {
  
    document.getElementById("age").selectedIndex = 0;
    document.querySelector("select.select-secondary").selectedIndex = 0;
    
    //reset source selector
    $("input[type=checkbox].btn")[0].checked=false
    $("input[type=checkbox].btn")[1].checked=false

    // grid.updateConfig({
    //   server: {
    //     url: "/text/json_rr_writelines.json",
    //     then: data => data.map(item => [
    //       item.disease, item.rr, item.Age, item.sex,
    //       item.category, item.risk, item.outcome, item.source
    //     ])
    //   }
    // }).forceRender();
    
  grid.updateConfig({
  data: formatData(originalData)
  }).forceRender();
    
  });
</script>')

      #datatable(mtcars)

      # div(id = 'par', class='h-screen background-white',
      # HTML('<img h-40 p-2 bg-neutral id=shine src="https://seeklogo.com/images/H/hsc-public-health-agency-logo-E4CF7B4D14-seeklogo.com.png" />')
      # )
      ),

  # Page 3 - Disability Weights
  div(id='page3', class='nav-content hidden',
      div(style ='height:15px;'),
      h2("GBD 2021 Disability Weights", class="text-2xl font-bold mb-4"),
      
      HTML('<div class="w-full max-w-none overflow-x-auto">
        <div id="disability-weights-table" class="p-4"></div>
      </div>
<script>
  fetch("disability_weights.json")
    .then(res => res.json())
    .then(data => {
      // Format data for gridjs
      const formatted = data.map(row => [
        row.sequela_name,
        row.health_state_name,
        row.health_state_lay_description,
        parseFloat(row.mean).toFixed(4),
        parseFloat(row.lower).toFixed(4),
        parseFloat(row.upper).toFixed(4)
      ]);
      
      new gridjs.Grid({
        columns: [
          { name: "Sequela Name", width: "200px" },
          { name: "Health State Name", width: "150px" }, 
          { name: "Lay Description", width: "300px" },
          { name: "Mean", width: "80px" },
          { name: "Lower", width: "80px" },
          { name: "Upper", width: "80px" }
        ],
        data: formatted,
        pagination: { limit: 10 },
        search: true,
        sort: true,
        resizable: true,
        fixedHeader: true,
        style: {
          table: {
            "width": "100%",
            "table-layout": "fixed"
          }
        },
        className: {
          table: "table border border-base-300 text-sm",
          th: "bg-base-200 text-base-content text-left p-2 text-xs",
          td: "p-2 border border-base-300 text-xs overflow-hidden text-ellipsis",
          paginationButton: "btn btn-sm p-2 m-2 btn-outline",
          search: "input m-3 input-bordered input-sm w-full max-w-xs"
          //search: "w-full input"
        }
      }).render(document.getElementById("disability-weights-table"));
    });
</script>')
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

# <span><h5 class="inline"> Contact
# </h5>
#   <svg  class="inline fill-current" width="26" height="16" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" fill-rule="evenodd" clip-rule="evenodd" class="fill-current"><path d="M22.672 15.226l-2.432.811.841 2.515c.33 1.019-.209 2.127-1.23 2.456-1.15.325-2.148-.321-2.463-1.226l-.84-2.518-5.013 1.677.84 2.517c.391 1.203-.434 2.542-1.831 2.542-.88 0-1.601-.564-1.86-1.314l-.842-2.516-2.431.809c-1.135.328-2.145-.317-2.463-1.229-.329-1.018.211-2.127 1.231-2.456l2.432-.809-1.621-4.823-2.432.808c-1.355.384-2.558-.59-2.558-1.839 0-.817.509-1.582 1.327-1.846l2.433-.809-.842-2.515c-.33-1.02.211-2.129 1.232-2.458 1.02-.329 2.13.209 2.461 1.229l.842 2.515 5.011-1.677-.839-2.517c-.403-1.238.484-2.553 1.843-2.553.819 0 1.585.509 1.85 1.326l.841 2.517 2.431-.81c1.02-.33 2.131.211 2.461 1.229.332 1.018-.21 2.126-1.23 2.456l-2.433.809 1.622 4.823 2.433-.809c1.242-.401 2.557.484 2.557 1.838 0 .819-.51 1.583-1.328 1.847m-8.992-6.428l-5.01 1.675 1.619 4.828 5.011-1.674-1.62-4.829z"></path></svg>
#   </span>
  
#bg-neutral  text-neutral-content
# Fixed footer with proper Tailwind classes
HTML('<footer class="fixed bottom-0 left-0 w-full z-50 bg-base-200 text-base-content border-t border-base-300 shadow-lg">
  <div class="flex flex-col md:flex-row justify-between items-center px-4 py-3 gap-2">
    <!-- Left section: Contact info -->
    <div class="flex items-center gap-2">
      <svg class="inline fill-current" width="20" height="20" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" fill-rule="evenodd" clip-rule="evenodd">
        <path d="M22.672 15.226l-2.432.811.841 2.515c.33 1.019-.209 2.127-1.23 2.456-1.15.325-2.148-.321-2.463-1.226l-.84-2.518-5.013 1.677.84 2.517c.391 1.203-.434 2.542-1.831 2.542-.88 0-1.601-.564-1.86-1.314l-.842-2.516-2.431.809c-1.135.328-2.145-.317-2.463-1.229-.329-1.018.211-2.127 1.231-2.456l2.432-.809-1.621-4.823-2.432.808c-1.355.384-2.558-.59-2.558-1.839 0-.817.509-1.582 1.327-1.846l2.433-.809-.842-2.515c-.33-1.02.211-2.129 1.232-2.458 1.02-.329 2.13.209 2.461 1.229l.842 2.515 5.011-1.677-.839-2.517c-.403-1.238.484-2.553 1.843-2.553.819 0 1.585.509 1.85 1.326l.841 2.517 2.431-.81c1.02-.33 2.131.211 2.461 1.229.332 1.018-.21 2.126-1.23 2.456l-2.433.809 1.622 4.823 2.433-.809c1.242-.401 2.557.484 2.557 1.838 0 .819-.51 1.583-1.328 1.847m-8.992-6.428l-5.01 1.675 1.619 4.828 5.011-1.674-1.62-4.829z"></path>
      </svg>
      <div class="text-xs flex gap-3">
        <a class="link link-primary hover:link-accent" href="mailto:aaron.gorman@hscni.net">Developer</a>
        <a class="link hover:link-accent" href="mailto:paul.mcwilliams@hscni.net">Business Owner</a>
      </div>
    </div>
    
    <!-- Right section: Social links -->
    <div class="flex items-center gap-3">
      <a href="https://twitter.com/publichealthni" class="hover:text-primary transition-colors" title="Twitter">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" class="fill-current">
          <path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z"></path>
        </svg>
      </a>
      <a href="https://www.youtube.com/user/PublicHealthAgency" class="hover:text-primary transition-colors" title="YouTube">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" class="fill-current">
          <path d="M19.615 3.184c-3.604-.246-11.631-.245-15.23 0-3.897.266-4.356 2.62-4.385 8.816.029 6.185.484 8.549 4.385 8.816 3.6.245 11.626.246 15.23 0 3.897-.266 4.356-2.62 4.385-8.816-.029-6.185-.484-8.549-4.385-8.816zm-10.615 12.816v-8l8 3.993-8 4.007z"></path>
        </svg>
      </a>
      <a href="https://www.facebook.com/publichealthagency/" class="hover:text-primary transition-colors" title="Facebook">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" class="fill-current">
          <path d="M9 8h-3v4h3v12h5v-12h3.642l.358-4h-4v-1.667c0-.955.192-1.333 1.115-1.333h2.885v-5h-3.808c-3.596 0-5.192 1.583-5.192 4.615v3.385z"></path>
        </svg>
      </a>
    </div>
  </div>
  
  <!-- Copyright bar -->
  <div class="bg-base-300 text-center py-1">
    <p class="text-xs opacity-70">  2025 - Population Health Model from Public Health Agency</p>
  </div>
</footer>'
     )
)
)

library(httpuv)

# Function to modify response headers


server <- function(input, output, session) {
  
  observeEvent(input$baseline_checkbox,{
    print(input$baseline_checkbox)
  })
  
  observeEvent(input$gbd,{
    session$sendCustomMessage(
      type = "notify",
      message = list(text = input$gbd)
    )
    print(input$gbd)
    
    }
  )
  
  observeEvent(input$sapm,{
    session$sendCustomMessage(
      type = "notify",
      message = list(text = input$sapm)
    )
    print(input$sapm)
    }
  )
  
observeEvent(input$hello, {
  print('Shiny Checkbox')
  print(input$hello)
  }
  ) 
  
  observeEvent(input$age1, {
    print('Shiny Select')
    print(input$age1)
    
  }
  ) 
  
  observeEvent(input$age, {
    print('non-shiny age select')
    print(input$age)
  }
  ) 
  
    output$relative_risk = renderDT(server = T,{
      mtcars
      })
    
    session$onSessionEnded(function(session) {
      print('onSessionEnded event callback fired')
      httpuv::stopServer(httpuv::listServers()[[1]])
    })
    
}
    
    modify_headers <- function(req, res) {
      res$setHeader("Access-Control-Allow-Origin", "*")
      res$setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
      res$setHeader("Access-Control-Allow-Headers", "Content-Type")
    }

shinyApp(ui, server ,onStart = function() {
  print(resourcePaths())
  httpuv::startServer(
    "0.0.0.0", 6064,
    list(call = modify_headers)
  )
  })
