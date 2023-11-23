import { FooterMain } from "@/components/footer";
import { HeaderDoctor } from "@/components/header";
import styles from './style.module.scss'
import { RxExit } from "react-icons/rx";
import Link from "next/link";
import { FormUpdateDoctor } from "@/components/forms";

export default function Medico() {
    return (
        <>
            <HeaderDoctor />

            <main className={styles.menu}>
                <div className={styles.container}>
                    <h2>Dados da Conta</h2>

                    <FormUpdateDoctor />
                </div>
            </main>

            <Link href={'/'} className={styles['link-exit']}><RxExit size='28px'/></Link>

            <FooterMain />
        </>
    )
}