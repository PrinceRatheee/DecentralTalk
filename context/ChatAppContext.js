import React,{useEffect,useState} from "react";
import { useRouter } from "next/navigation"; 


//INTERNAL IMPORT
import { CheckIfWalletConnected ,connectWallet,connectingWithContract} from "../utils/apiFeature";

export const ChatAppContext=React.createContext();

export const ChatAppProvider=({children})=>{
    const title="Hey welcome to Decentral Talk";

    return(
        <ChatAppContext.Provider value={{title}}>
            {children}
        </ChatAppContext.Provider>
    )
}