
   
function opentab(page){
  const tabs = document.querySelectorAll(".navbar");
  console.log(tabs);
    const contents = document.querySelectorAll(".nav-content");
    console.log(contents);
    // remove twTab-active and twTabContent-active classes and hide content
    tabs.forEach(tab => {
      tab.classList.remove("active");
      // set active tab
      if (tab.id == page) tab.classList.add("active");
    });
    contents.forEach(c => {
      c.classList.remove("active");
      c.classList.add("hidden");
      c.style.display = "none";
      // show content tab
      if (c.id == page) {
        c.classList.remove("hidden");
        c.classList.add("active");
        //c.style.display = "block";
        //$(c).trigger("shown");
        $(c).show()
      };
    });
}

