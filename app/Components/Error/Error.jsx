import React from 'react'

// INTERNAL IMPORT 
import Style from "./Error.modulo.css";


const Error = ({error}) => {
  return (
    <div className={Style.Error}>
      <div className={Style.Error_box}>
        <h1>Please fix this error and reload browser</h1>
        {error}
      </div>
    </div>
  )
}

export default Error