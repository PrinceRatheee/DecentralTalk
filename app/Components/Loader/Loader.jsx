import Image from 'next/image'
import React from 'react'

//INTERNAL IMPORT
import Style from "./Loader.modulo.css";
import images from "../../assets";


function Loader() {
  return (
    <div className={Style.Loader}>
      <div className={Style.Loader_box}>
        <Image src={images.loader} alt='loader' width={100} height={100} />
      </div>
    </div>
  )
}

export default Loader