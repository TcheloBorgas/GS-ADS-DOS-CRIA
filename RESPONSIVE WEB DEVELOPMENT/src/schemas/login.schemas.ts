import { z } from "zod";

const loginSchema = z.object({
    email: z.string().nonempty('E-mail obrigatório').email('Forneça um e-mail válido'),
    senha: z.string().nonempty('Senha obrigatória')
})

export {
    loginSchema
}