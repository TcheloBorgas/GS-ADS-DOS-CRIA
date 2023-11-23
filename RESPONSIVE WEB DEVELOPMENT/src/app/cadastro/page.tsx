import Link from 'next/link'
import styles from './style.module.scss'
import { HeaderMain } from '@/components/header'
import { FooterMain } from '@/components/footer'

export default function Cadastro() {
    return (
        <>
            <HeaderMain />

            <main className={styles.menu}>
                <Link href={'/cadastro-medico'} className={styles.link} style={{marginTop: '-10vh'}}>Cadastro Médico</Link>
                <Link href={'/cadastro-paciente'} className={styles.link}>Cadastro Paciente</Link>
            </main>

            <FooterMain />        
        </>
    )
}