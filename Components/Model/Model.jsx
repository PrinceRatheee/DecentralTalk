import React,{useState,useContext} from 'react'
import Image from 'next/image';


//INTERNAL IMPORT
import Style from './Model.module.css';
import images from "../../assets/index";
import { ChatAppContext } from '../../context/ChatAppContext';
import {Loader} from '../../Components/Loader/Loader';
const Model = ({openModel,title,head,info,smallInfo,images,functionName}) => {

  //USESTATE
  const[name,setName]=useState("");
  return (
    <div>Model</div>
  )
}

export default Model