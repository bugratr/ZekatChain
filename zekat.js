let web3 = new Web3(Web3.givenProvider);
let contractAddress = "AKILLI_SOZLESME_ADRESINIZ"; // Buraya akıllı sözleşmenizin adresini ekleyin
let contractABI = []; // Akıllı sözleşmenizin ABI bilgisini ekleyin

let contract = new web3.eth.Contract(contractABI, contractAddress);

async function donate() {
    if (typeof window.ethereum !== 'undefined' || (typeof window.web3 !== 'undefined')) {
        const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
        const account = accounts[0];
        let amount = document.getElementById('amount').value;
        let amountInWei = web3.utils.toWei(amount, "ether");

        contract.methods.bagisYap().send({from: account, value: amountInWei})
        .then(receipt => {
            alert("Bağış başarıyla gerçekleştirildi!");
        })
        .catch(error => {
            alert("Bağış gerçekleştirilirken bir hata oluştu: " + error.message);
        });
    } else {
        alert('Ethereum cüzdanınızı kontrol edin!');
    }
}
