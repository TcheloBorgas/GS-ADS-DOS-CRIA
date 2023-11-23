import { FooterMain } from "@/components/footer";
import { HeaderPatient } from "@/components/header";
import styles from './style.module.scss'
import { FormUpdatePatient } from "@/components/forms";
import Link from "next/link";
import { RxExit } from "react-icons/rx";

export default function Paciente() {
    return (
        <>
            <HeaderPatient />

            <main className={styles.menu}>
                <div className={styles.container}>
                    <h2>Dados da Conta</h2>

                    <FormUpdatePatient />
                </div>
            </main>

            <Link href={'/'} className={styles['link-exit']}><RxExit size='28px'/></Link>

            <FooterMain />
        </>
    )
}