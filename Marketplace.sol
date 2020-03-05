pragma solidity ^0.6.0;


contract Marketplace{
    struct product{
        uint id;
        address itemOwner;
        uint price;
        bool available;
    }
    address buyer;
mapping(address => bool) public itemOwner;
  mapping(uint => bool) public  ItemAvailability;
  

  //using events mainly for product states

event ItemAvailable (address seller, uint id, uint price);
event offerPlaced(uint amount, address buyer);
event accepted(uint indexed id);
event rejected(uint indexed id);
event itemSold(uint indexed id);


modifier onlyOwner(){
    require(itemOwner[msg.sender] == true, 'you are not the item owner');
    _;
}


function makeAvailaible(uint price, uint id) public payable onlyOwner {

    emit ItemAvailable(msg.sender,id,price);
    require(ItemAvailability[id]== true);

}

function makeOffer(uint _price, uint id) public {
    emit offerPlaced(_price,msg.sender);
    ItemAvailability[id]==false;
   
}
function acceptOffer(uint id) public onlyOwner returns (bool) {
    emit accepted(id);
    emit itemSold(id);
}
function rejectOffer(uint id) public onlyOwner returns (bool) {
    emit rejected (id);
    ItemAvailability[id]==true;
}


} 
