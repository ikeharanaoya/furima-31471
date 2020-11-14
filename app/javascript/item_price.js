window.addEventListener("DOMContentLoaded", ()=>{
  // 現在ページのURLのパス名を取得
  const path = location.pathname
  // 商品出品画面
  const pathNew = "/items/new"
  // 商品出品画面（入力エラー時）
  const pathError = "/items"

  // 商品出品画面の場合
  if(path === pathNew || path === pathError) {
    // 価格
    const itemPrice = document.getElementById("item-price");
    // 販売手数料
    const addTaxPriceDom = document.getElementById("add-tax-price");
    // 販売利益
    const profitDom = document.getElementById("profit");

    // 価格を入力した場合
    itemPrice.addEventListener("input",()=>{
      // 価格の入力値を取得
      const price = itemPrice.value;

      // 販売手数料を計算：(価格*0.1)で小数点切り捨て
      let tax = Math.floor(price * 0.1);
      // 販売利益を計算：価格ー販売手数料
      let profit = (price - tax);

      // 販売手数料に算出結果を設定（フォーマット変更も行う）
      addTaxPriceDom.innerHTML = tax.toLocaleString();
      // 販売利益に算出結果を設定（フォーマット変更も行う）
      profitDom.innerHTML = profit.toLocaleString();
    });
  }
});