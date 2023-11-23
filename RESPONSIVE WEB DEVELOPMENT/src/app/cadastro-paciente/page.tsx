import { FooterMain } from "@/components/footer";
import { HeaderMain } from "@/components/header";
import styles from './style.module.scss'
import { FormPatient } from "@/components/forms";

export default function Cadastro() {
    return (
        <>
            <HeaderMain />

            <main className={styles.menu}>
                <div className={styles.container}>
                    <h2>Cadastro de Conta (Paciente)</h2>

                    <FormPatient />
                </div>
            </main>

            <FooterMain />
        </>
    )
}