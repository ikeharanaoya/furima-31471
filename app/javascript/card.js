window.addEventListener("DOMContentLoaded", () => {
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
    // 環境変数から取得
    const PAYJP_PK = process.env.PAYJP_PUBLIC_KEY
    Payjp.setPublicKey(PAYJP_PK);

    // フォームの情報を取得
    const form = document.getElementById("charge-form");

    // 購入ボタンを押した場合
    form.addEventListener("submit",(e) => {
      // フォーム送信処理をキャンセル
      e.preventDefault();

      // 購入情報の送信処理（フォーム情報のクリア）
      const sendWithoutCardInfo = () => {
        // カード情報クリア
        document.getElementById("card-number").removeAttribute("name");
        document.getElementById("card-cvc").removeAttribute("name");
        document.getElementById("card-exp-month").removeAttribute("name");
        document.getElementById("card-exp-year").removeAttribute("name");
        // フォームの再送信
        document.getElementById("charge-form").submit();
        // フォーム情報の全項目クリア
        document.getElementById("charge-form").reset();
      }

      // フォームの情報を取得
      const formResult = document.getElementById("charge-form");
      // FormDataオブジェクトとして生成して、jsで使えるようにする
      const formData = new FormData(formResult);

      // カード情報を設定
      const card = {
        // クレジットカードに関する情報を取得
        number: formData.get("item_buy[number]"),
        cvc: formData.get("item_buy[cvc]"),
        exp_month: formData.get("item_buy[exp_month]"),
        exp_year: `20${formData.get("item_buy[exp_year]")}`,
      };

      // カードの情報をトークン化
      Payjp.createToken(card, (status,response) => {
        // ステータス確認
        if (status === 200) {
          // 正常終了した場合
          // トークンを取得
          const token = response.id;
          // トークン情報を追加するフォームを取得
          const renderDom = document.getElementById("charge-form");
          // 追加するトークン情報を生成
          const tokenObj = `<input value=${token} name='token' type="hidden" >`;
          // フォームの中にトークン情報を追加
          renderDom.insertAdjacentHTML("beforeend", tokenObj);
          // 購入情報の送信処理（フォーム情報のクリア）
          sendWithoutCardInfo()
        } else {
          // 異常終了した場合
          // 購入情報の送信処理（フォーム情報のクリア）
          sendWithoutCardInfo()
        }
      });
    });
  }
});