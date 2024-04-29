// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Bugs is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;
    uint256 public constant MAX_SUPPLY = 10;
    uint256 public totalSupplyMinted;
    uint256 public mintPrice = 0.00 ether;
    string private _baseURIextended;

    constructor()
        ERC721("Bugs", "BUGS")
        Ownable(msg.sender)
    {
        _nextTokenId = 0;
        totalSupplyMinted = 0;
        _baseURIextended = "ipfs://QmVnSTnhLKpvvVuDZibgkGJkPdaLWSDiuymXgQySzHQ54v/";
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseURIextended;
    }

    // Function to allow the owner to change the base URI
    function setBaseURI(string memory newBaseURI) public onlyOwner {
        _baseURIextended = newBaseURI;
    }

    function setMintPrice(uint256 _price) public onlyOwner {
        mintPrice = _price;
    }

    function safeMint(address to) public payable {
        require(msg.value >= mintPrice, "Insufficient funds");
        uint256 tokenId = _nextTokenId++;
        require(tokenId < MAX_SUPPLY, "Max supply reached");
        _safeMint(to, tokenId);
        totalSupplyMinted++;
    }

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}