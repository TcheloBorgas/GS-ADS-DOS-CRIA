import { FooterMain } from "@/components/footer";
import { HeaderMain } from "@/components/header";
import styles from "./style.module.scss";
import Link from "next/link";
import { FormLogin } from "@/components/forms";

export default function Login() {
    return (
        <>
            <HeaderMain />

            <main className={styles.menu}>
                <h2>Faça o seu Login</h2>

                <FormLogin />

                <Link href={"/cadastro"} className={styles['link-register']}>
                    Ainda não possui uma conta? Faça o seu cadastro
                </Link>
            </main>

            <FooterMain />
        </>
    );
}
