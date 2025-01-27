import { Inter } from "next/font/google";
import "./globals.css";

//INTERNAL IMPORT

import Navbar from "./Components/Navbar/Navbar";
import { Toaster } from "react-hot-toast";
import { ChatAppProvider } from "./context/ChatAppContext";

const inter = Inter({ subsets: ["latin"] });

export const metadata = {
  title: "DecentralTalk",
  description: "Decentralised Chatting Application",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      
      <body>


        
        <ChatAppProvider>

          <Navbar />
          <Toaster/> 
          {children}
          {/* <Footer/> */}

        </ChatAppProvider>


      </body>
    </html>
  );
}
