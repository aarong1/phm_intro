
//function handleClick(event){
//  
//  if(document.querySelector("html").getAttribute("data-theme") === "synthwave"){
//    
//  document.querySelector("html").setAttribute("data-theme", "cupcake")
//  }
//  else{
//      document.querySelector("html").setAttribute("data-theme", "synthwave")
//
//  }
//
//}


  
function handleClick(event){
  
  if(document.querySelector("html").getAttribute("data-theme") === "black"){
  document.querySelector("html").setAttribute("data-theme", "light")
  }
  else if(document.querySelector("html").getAttribute("data-theme") === "light"){
      document.querySelector("html").setAttribute("data-theme", "dark")
}
  else if(document.querySelector("html").getAttribute("data-theme") === "dark"){
      document.querySelector("html").setAttribute("data-theme", "cupcake")

  }  
  else if(document.querySelector("html").getAttribute("data-theme") === "cupcake"){
      document.querySelector("html").setAttribute("data-theme", "synthwave")

  }  
   else if(document.querySelector("html").getAttribute("data-theme") === "synthwave"){
      document.querySelector("html").setAttribute("data-theme", "black")

  }  

}

   