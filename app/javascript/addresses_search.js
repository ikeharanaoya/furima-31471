window.addEventListener("DOMContentLoaded", ()=>{
  // 現在ページのURLのパス名を取得
  const path = location.pathname
  // パラメーターの値をパスから取得
  const params = path.replace(/items/g, '').replace(/orders/g, '').replace(/\//g, '');

  // 商品のパス
  const path_items = "items"
  // 商品購入のパス
  const path_orders = "orders"
  // 0以上の整数のみ（ゼロ埋めなし）
  const paramsRegex = /^([1-9]\d*|0)$/

  // 商品購入画面の場合
  if(path.includes(path_items) && path.includes(path_orders) && paramsRegex.test(params)) {
    // 流用ボタン
    const DiversionBtn = document.getElementById("DiversionBtn");

    DiversionBtn.addEventListener("click", (e) => { 
      // フォーム送信処理をキャンセル
      e.preventDefault();
      console.log("click");
      // XMLHttpRequestを生成
      const XHR = new XMLHttpRequest();
      // XMLHttpRequestを初期化
      XHR.open("GET", `${location.pathname}/addresses_search`, true);
      // レスポンスの形式を定義
      XHR.responseType = "json";
      // 送信
      XHR.send();
      // 受信後の処理
      XHR.onload = () => {
        // エラー確認
        if (XHR.status != 200) {
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          return null
        }
        
      console.log("OK");
      };
    });
  }
});