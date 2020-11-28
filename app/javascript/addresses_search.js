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
    const diversionBtn = document.getElementById("diversion-btn");

    diversionBtn.addEventListener("click", (e) => { 
      // フォーム送信処理をキャンセル
      e.preventDefault();
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
        // ユーザー住所情報を取得
        const user_addresses = XHR.response.post;
        // フォームの情報を取得
        const formResult = document.getElementById("charge-form");
        // FormDataオブジェクトとして生成して、jsで使えるようにする
        const formData = new FormData(formResult);

        // ユーザーの住所情報を設定
        document.getElementById("postal-code").value = user_addresses[0].postal_code;
        document.getElementById("prefecture").value = user_addresses[0].prefecture_id;
        document.getElementById("city").value = user_addresses[0].city;
        document.getElementById("addresses").value = user_addresses[0].addresses;
        document.getElementById("building").value = user_addresses[0].building;
        document.getElementById("phone-number").value = user_addresses[0].phone_number;
      };
    });

    // クリアボタン
    const resetBtn = document.getElementById("reset-btn");

    resetBtn.addEventListener("click", (e) => { 
      // フォーム送信処理をキャンセル
      e.preventDefault();
      // 住所情報の全項目クリア
      document.getElementById("postal-code").value = "";
      document.getElementById("prefecture").value = 0;
      document.getElementById("city").value = "";
      document.getElementById("addresses").value = "";
      document.getElementById("building").value = "";
      document.getElementById("phone-number").value = "";
    });
  }
});