document.addEventListener('DOMContentLoaded', () => { // DOMが完全にロードされたことを確認
  const priceInput = document.getElementById('item-price');
  const addTaxDom = document.getElementById('add-tax-price');
  const profitDom = document.getElementById('profit');

  if (priceInput && addTaxDom && profitDom) { // 要素が存在するか確認
    priceInput.addEventListener('input', () => {
      const inputValue = priceInput.value;

      // 価格の10％として販売税を計算
      const tax = Math.floor(inputValue * 0.1);

      // 入力された価格から販売税を引いて利益を計算
      const profit = inputValue - tax;

      // HTMLに販売税と利益を表示
      addTaxDom.textContent = tax.toLocaleString(); // toLocaleString()は数値を通貨形式に変換します
      profitDom.textContent = profit.toLocaleString();
    });
  }
});
