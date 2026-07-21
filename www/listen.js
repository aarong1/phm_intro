
function handleClick(event){
  
  if(document.querySelector("html").getAttribute("data-theme") === "synthwave"){
    
  document.querySelector("html").setAttribute("data-theme", "cupcake")
  }
  else{
      document.querySelector("html").setAttribute("data-theme", "synthwave")

  }

}


   