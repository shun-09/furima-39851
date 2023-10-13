function count (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const taxPrice = Math.floor( itemPrice.value * 0.1 );
    const addTax = document.getElementById("add-tax-price");
    addTax.innerHTML = taxPrice;
    const profit = Math.floor( itemPrice.value - taxPrice );
    const addProfit = document.getElementById("profit");
    addProfit.innerHTML = profit;    
  });
};

window.addEventListener('turbo:load', count);
window.addEventListener('turbo:render', count);