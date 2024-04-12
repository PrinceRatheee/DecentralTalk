// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract ChatApp{
    //user struct
    struct user{
        string name;
        friend[] friendList;  // all the friends of user will be in this array
    }
    struct friend{
        address pubKey;
        string name;
    }

    struct message{
        address sender;
        uint256 timestamp;
        string msg;
    }
    struct AllUserStruct{  // to store all the users registered in the platform
        string name;
        address accountAddress;
    }
    mapping(address=>user) userList; 
    mapping(bytes32=>message[]) allMessages; // to get all the messages between two user
    AllUserStruct[] getAllUsers;

    //CHECK USER EXIST
    function checkUserExists(address pubKey) public view returns(bool){
        return bytes(userList[pubKey].name).length>0;
    }


    //Create account or Register User
    function createAccount(string calldata name) external{ // callData to save gas fee
        require(checkUserExists(msg.sender)== false,"User already exists");
        require(bytes(name).length>0,"Username cannot be empty");

        userList[msg.sender].name=name;
        getAllUsers.push(AllUserStruct(name,msg.sender));
    }

    //GET USERNAME
    function getUsername(address  pubKey) external view returns(string memory){
        require(checkUserExists(pubKey),"User is not registered");
        return userList[pubKey].name;
    }

    //ADD FRIEND
    function addFriend(address friend_key,string calldata name) external {
        require(checkUserExists(msg.sender),"Register yourself first");
        require(checkUserExists(friend_key),"User is not resitered");
        require(msg.sender!=friend_key,"User cannot send friend request to yourself");
        require(checkAlreadyFriends(msg.sender,friend_key)==false,"These users are already friends");

        _addFriend(msg.sender,friend_key,name);
        _addFriend(friend_key,msg.sender,userList[msg.sender].name);
    }

    // check whether two users are already friends
    function checkAlreadyFriends(address pubKey1,address pubKey2) internal view returns(bool){

        if(userList[pubKey1].friendList.length>userList[pubKey2].friendList.length){
            address temp=pubKey1;
            pubKey2=pubKey1;
            pubKey1=temp;
        }
        for (uint256 i=0;i<userList[pubKey1].friendList.length;i++){
            if(userList[pubKey1].friendList[i].pubKey==pubKey2) return true;
        }
        return false;
    }

    //to add friend internal function
    function _addFriend(address me,address friend_key,string memory name) internal{
        friend memory newFriend =friend(friend_key,name);
        userList[me].friendList.push(newFriend);
    }


    //GET MY FRIEND
    function getMyFriendList() external view returns(friend[] memory){
        return userList[msg.sender].friendList;
    }

    //get chat code internal function 
    function _getChatCode(address pubKey1,address pubKey2) internal pure returns(bytes32){
        if(pubKey1<pubKey2){
            return keccak256(abi.encodePacked(pubKey1,pubKey2));
        }else{
            return keccak256(abi.encodePacked(pubKey2,pubKey1));
        }
    }

    //SEND MESSAGE FUNCTION
    function sendMessage(address friend_key,string calldata _msg) external{
        require(checkUserExists(msg.sender),"Create an account first");
        require(checkUserExists(friend_key),"Friend is not registered");
        require(checkAlreadyFriends(msg.sender,friend_key),"You are not friend with the given user");

        bytes32 chatCode=_getChatCode(msg.sender,friend_key);
        message memory newMsg=message(msg.sender,block.timestamp,_msg);
        allMessages[chatCode].push(newMsg);
    }


    //READ MESSAGE FUNCTION
    function readMessage(address friend_key) external view returns(message[] memory){
        bytes32 chatCode=_getChatCode(msg.sender,friend_key);
        return allMessages[chatCode];
    }

    // to get all the registered users 
    function getAllAppUser() public view returns(AllUserStruct[] memory){
        return getAllUsers;
    }

}