window.addEventListener('turbo:load', () => {
  console.log("OK");
});

const priceInput = document.getElementById('item-price');
const addTaxDom = document.getElementById('add-tax-price');
const profitDom = document.getElementById('profit');

priceInput.addEventListener('input', () => {
  const inputValue = priceInput.value;
  
  // 販売手数料の計算（価格の10%）
  const tax = Math.floor(inputValue * 0.1);
  
  // 利益の計算（価格の90%）
  const profit = Math.floor(inputValue * 0.9);
  
  // 販売手数料と利益をHTMLに表示
  addTaxDom.textContent = tax.toLocaleString(); // toLocaleString()は数値を通貨形式に変換します
  profitDom.textContent = profit.toLocaleString();
});

