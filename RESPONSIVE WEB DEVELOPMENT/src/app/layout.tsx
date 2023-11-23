/* eslint-disable @next/next/no-page-custom-font */
import { Metadata } from "next"
import '../scss/main.scss'

export const metadata: Metadata = {
  title: 'ConsulTech',
  description: 'Aqui você encontra',
  icons: 'https://cdn-icons-png.flaticon.com/512/5405/5405432.png'
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="pt-BR">
      <head>
        <meta httpEquiv="X-UA-Compatible" content="IE=edge" />
        <link rel="preconnect" href="https://fonts.googleapis.com"/>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin=""/>
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
      </head>
      <body>{children}</body>
    </html>
  )
}
