// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ZekatChain {
    address public sahip;
    uint256 public operasyonelYuzde = 2; // %2
    mapping(address => Basvuran) public basvuranlar;

    struct Basvuran {
        bool kayitliMi;
        bool aldiMi;
        address cüzdan;
    }

    modifier sadeceSahip() {
        require(msg.sender == sahip, "Bu islemi sadece sahip gerceklestirebilir.");
        _;
    }

    constructor() {
        sahip = msg.sender;
    }

    function basvuranKaydet(address basvuranAdres) external sadeceSahip {
        require(!basvuranlar[basvuranAdres].kayitliMi, "Basvuran zaten kayitli.");

        basvuranlar[basvuranAdres] = Basvuran({
            kayitliMi: true,
            aldiMi: false,
            cüzdan: address(0)
        });
    }

    function cüzdanAdresiBelirle(address cüzdan) external {
        require(basvuranlar[msg.sender].kayitliMi, "Basvuran kayitli degil.");
        require(!basvuranlar[msg.sender].aldiMi, "Basvuran zaten zekat aldi.");

        basvuranlar[msg.sender].cüzdan = cüzdan;
    }

    function bagisYap() external payable {
        require(msg.value > 0, "Miktarin 0'dan buyuk olmasi gerekiyor.");

        uint256 operasyonelMiktar = (msg.value * operasyonelYuzde) / 100;
        uint256 bagisMiktar = msg.value - operasyonelMiktar;

        payable(sahip).transfer(operasyonelMiktar); // operasyonel masraf icin transfer

        address[] memory adresler = rastgeleBasvuranAl();
        for (uint i = 0; i < adresler.length; i++) {
            payable(adresler[i]).transfer(bagisMiktar);
            basvuranlar[adresler[i]].aldiMi = true;
        }
    }

    function rastgeleBasvuranAl() internal view returns(address[] memory) {
        address[] memory kayitliAdresler = new address[](1); // su an sadece 1 kisiye gonderiyoruz, bu genisletilebilir
        uint sayac = 0;

        for (uint i = 0; i < 1; i++) { // ayni nedenle sadece bir adres ariyoruz su an
            address simdiki = address(uint(keccak256(abi.encodePacked(sayac, block.timestamp))));
            while (!basvuranlar[simdiki].kayitliMi || basvuranlar[simdiki].aldiMi || basvuranlar[simdiki].cüzdan == address(0)) {
                simdiki = address(uint(keccak256(abi.encodePacked(simdiki, block.timestamp))));
            }
            kayitliAdresler[i] = simdiki;
        }

        return kayitliAdresler;
    }
}

