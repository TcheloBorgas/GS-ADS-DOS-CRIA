import { z } from "zod";

const updateDoctorSchema = z.object({
    nome: z.string().max(150, 'Máximo de 150 caracteres').nullish(),
    email: z.union([z.string().email('Forneça um e-mail válido').nullish().default(null), z.string().max(0)]),
    senha: z.union([z.string()
        .min(8, "A senha precisa conter pelo menos 8 caracteres")
        .regex(/(?=.*?[#?!@$%^&*-])/, "É necessário pelo menos um caracter especial")
        .regex(/(?=.*?[A-Z])/, "É necessário pelo menos uma letra maiúscula")
        .regex(/(?=.*?[a-z])/, "É necessário pelo menos uma letra minúscula")
        .nullish().default(null), z.string().max(0)]),
    cpf: z.union([z.string().min(11, 'Mínimo de 11 dígitos').max(11, 'Máximo de 11 dígitos').nullish(), z.string().max(0)]),
    crm: z.union([z.string().nonempty('O CRM é obrigatório').min(4, 'Mínimo de 4 dígitos').max(15, 'Máximo de 15 dígitos'), z.string().max(0)]),
    endereco: z.union([z.string().nonempty('Endereço obrigatório').min(6, 'Exemplo: Rua Fagundes, 58').max(80, 'Máximo de 80 caracteres'), z.string().max(0)]),
    estado: z.union([z.string().nonempty('Estado obrigatório'), z.string().max(0)]),
    cidade: z.union([z.string().nonempty('Cidade obrigatória'), z.string().max(0)]),
    cep: z.union([z.string().nonempty('CEP obrigatório').min(8, 'Mínimo de 8 dígitos').max(8, 'Máximo de 8 dígitos'), z.string().max(0)])
})

const updateDaysDoctorSchema = z.object({
    segunda: z.boolean().default(false),
    terca: z.boolean().default(false),
    quarta: z.boolean().default(false),
    quinta: z.boolean().default(false),
    sexta: z.boolean().default(false),
    sabado: z.boolean().default(false),
})

export {
    updateDoctorSchema,
    updateDaysDoctorSchema,
}