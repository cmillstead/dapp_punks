// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./ERC721Enumerable.sol";
import "./Ownable.sol";

contract NFT is ERC721Enumerable, Ownable {
    uint256 public cost;
    uint256 public maxSupply;
    uint256 public allowMintingOn;
    string public baseURI;

    // using Strings for uint256;

    // uint256 public constant MAX_NFT_SUPPLY = 10000;
    // uint256 public constant MAX_MINT_PER_TX = 20;
    // uint256 public constant PRICE = 0.05 ether;

    // string private _baseTokenURI;
    // bool public _saleIsActive = false;

    constructor(
        string memory _name, 
        string memory _symbol,
        uint256 _cost,
        uint256 _maxSupply,
        uint256 _allowMintingOn,
        string memory _baseURI
    ) ERC721 (  
        _name, 
        _symbol
    ) {
        cost = _cost;
        maxSupply = _maxSupply;
        allowMintingOn = _allowMintingOn;
        baseURI = _baseURI;
        // setBaseURI(baseURI); 
    }

    // function mint(uint256 numberOfTokens) public payable {
    //     require(_saleIsActive, "Sale must be active to mint NFT");
    //     require(
    //         numberOfTokens <= MAX_MINT_PER_TX,
    //         "Can only mint 20 tokens at a time"
    //     );
    //     require(
    //         totalSupply() + numberOfTokens <= MAX_NFT_SUPPLY,
    //         "Purchase would exceed max supply of NFT"
    //     );
    //     require(
    //         PRICE * numberOfTokens <= msg.value,
    //         "Ether value sent is not correct"
    //     );

    //     for (uint256 i = 0; i < numberOfTokens; i++) {
    //         uint256 mintIndex = totalSupply();
    //         _safeMint(msg.sender, mintIndex);
    //     }
    // }

    // function setBaseURI(string memory baseURI) public  {
    //     _baseTokenURI = baseURI;
    // }

    // function setSaleIsActive(bool isActive) public  {
    //     _saleIsActive = isActive;
    // }

    // function _baseURI() internal view virtual override returns (string memory) {
    //     return _baseTokenURI;
    // }
}
