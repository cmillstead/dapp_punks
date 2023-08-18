// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./ERC721Enumerable.sol";
import "./Ownable.sol";

contract NFT is ERC721Enumerable, Ownable {
    using Strings for uint256;
    string public baseURI;
    string public baseExtension = ".json";    
    uint256 public cost;
    uint256 public maxSupply;
    uint256 public allowMintingOn;

    event Mint(
        uint256 amount,
        address minter
    );

    constructor(
        string memory _name, 
        string memory _symbol,
        uint256 _cost,
        uint256 _maxSupply,
        uint256 _allowMintingOn,
        string memory _baseURI
    ) ERC721(  
        _name, 
        _symbol
    ) {
        cost = _cost;
        maxSupply = _maxSupply;
        allowMintingOn = _allowMintingOn;
        baseURI = _baseURI;
    }

    function mint(uint256 _mintAmount) public payable {
        uint256 supply = totalSupply();

        require(
            _mintAmount > 0,
            "Must mint at least one NFT"
        );
        require(
            block.timestamp >= allowMintingOn,
            "Minting not allowed yet"
        );
        require(
            msg.value >= cost * _mintAmount,
            "Insufficient payment"
        );
        require(
            supply + _mintAmount <= maxSupply,
            "Exceeds maximum supply"
        );

        for (uint256 i = 1; i <= _mintAmount; i++) {
            _safeMint(msg.sender, supply + i);
        }

        emit Mint(_mintAmount, msg.sender);
    }

    function tokenURI(uint256 _tokenId) 
        public 
        view 
        virtual 
        override 
        returns (string memory) 
    {
        require(
            _exists(_tokenId),
            "Token does not exist"
        );

        return(
            string(
                abi.encodePacked(
                    baseURI,
                    _tokenId.toString(),
                    baseExtension
                )
            )
        );
    }

    function walletOfOwner(address _owner) 
        public 
        view 
        returns(uint256[] memory) 
    {
        uint256 tokenCount = balanceOf(_owner);
        uint256[] memory tokensId = new uint256[](tokenCount);
        for(uint256 i = 0; i < tokenCount; i++){
            tokensId[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokensId;
    }
}
