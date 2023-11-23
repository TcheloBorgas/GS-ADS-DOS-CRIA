import { HeaderMain } from '@/components/header'
import styles from './style.module.scss'
import Link from 'next/link'
import Image from 'next/image'
import Background from '../assets/images/conjunto-de-icones-de-vetor-de-tecnologia-medica-para-saude-e-bem-estar.jpg'
import { FooterMain } from '@/components/footer'

export default function Home() {
  return (
    <>
      <HeaderMain />
      
      <main className={styles.menu}>
        <div>
          <h2>
            Buscando a qualidade de vida que você merece, faça o seu cadastro e confira.
          </h2>

          <p>
            A Registro médico, é uma plataforma simples e de fácil usuabilidade onde os médicos
            poderão disponibilizar consultas e serem remunerados por isso, já os pacientes poderão
            marcar consulta com médicos de todas as especialidades, faça seu cadastro e confira.
          </p>
        
          <Link href={'/login'} className={styles['link-login']}>Login</Link>
          <Link href={'/cadastro'} className={styles['link-register']}>Cadastro</Link>
        </div>

        <Image 
          src={Background} 
          alt={'backround-saude'}
          className={styles.background}
        />
      </main>

      <FooterMain />
    </>
  )
}
