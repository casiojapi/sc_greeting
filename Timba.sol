// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract Timba {
    address public owner;
    // armamos un array para los timberos
    // modifier "payable" ya que alguno de estos degens va a ganar y le vamos a tener que pagar.
    address payable[] public timberos;

    constructor() {
        // owner address, es el address de la persona que deployea el contrato
        owner = msg.sender;
    }

    function getPozo() public view returns (uint) {
        return address(this).balance;
    }

    function getTimberos() public view returns (address payable[] memory) {
        return timberos;
    }

    // payable porque mete plata al pozo timbero
    function enter() public payable {
        // en este contexto -> msg.sender es el que invoca a la funcion. O sea el que la joinea (no deployea) [son dos contextos distintos]
        
        // minimo de entrada, casteo a ether, el default es gwei
        require(msg.value >= 0.01 ether);

        // agrego al timbero a la lista de timberos
        timberos.push(payable(msg.sender));
    }

    // por ahora solo vamos a tener pseudo randoms, la blockchain deterministica. Si sabemos el estado podemos predecir el resultado. Por ende nos pueden cagar
    // view -> no toca la blockchain
    function getRandNum() public view returns (uint) {
        // abi -> concatena los dos strings
        //keccak256 -> hashea y agarramos ese pseudo random num como randnum
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    // hacemos el checkeo en un modifier para no repetir codigo
    modifier onlyOwner() {
        require(msg.sender == owner);
        _; // corre lo que venga post lo de arriba
    }

    function rollTheDice() public onlyOwner{

        // sacamos random y modulus para que este en rango con la cantidad de timberos
        uint index = getRandNum() % timberos.length;
        // le pagamos al timbero el pozo completo
        timberos[index].transfer(address(this).balance);

        // reseteamos el array de timberos (de length 0)
        timberos = new address payable[](0);
    }


}