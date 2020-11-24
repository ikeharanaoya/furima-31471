window.addEventListener("DOMContentLoaded", ()=>{
  // 現在ページのURLのパス名を取得
  const path = location.pathname
  // トップ画面
  const pathRoot = "/"
  // 商品検索結果
  const pathSearch = "/items/search"

  if(path === pathRoot || path === pathSearch ) {
    // 商品の状態ラベル
    const searchSalesStatusLa = document.getElementById("sales_status_la")
    // 価格ラベル
    const searchPriceLa = document.getElementById("price_la")
    // 商品の状態：検索項目
    const searchSalesStatus = document.getElementById("sales_status")
    // 価格：検索項目
    const searchPrice = document.getElementById("price")

    searchSalesStatusLa.addEventListener('click', function() {
      // 商品の状態の表示と非表示の設定
      if (searchSalesStatus.getAttribute("style") == "display:block;") {
        // 項目を表示する
        searchSalesStatus.removeAttribute("style", "display:block;")
      } else {
        // 項目を非表示にする
        searchSalesStatus.setAttribute("style", "display:block;")
      }
    })

    searchPriceLa.addEventListener('click', function() {
      // 商品の状態の表示と非表示の設定
      if (searchPrice.getAttribute("style") == "display:block;") {
        // 項目を表示する
        searchPrice.removeAttribute("style", "display:block;")
      } else {
        // 項目を非表示にする
        searchPrice.setAttribute("style", "display:block;")
      }
    })
  }
});