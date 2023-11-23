import { z } from "zod"

const registerPatientSchema = z.object({
    nome: z.string().nonempty('Nome obrigatório').max(150, 'Máximo de 150 caracteres'),
    email: z.string().nonempty('E-mail obrigatório').email('Forneça um e-mail válido').max(80, 'Máximo de 80 caracteres'),
    senha: z.string()
    .min(8, "A senha precisa conter pelo menos 8 caracteres")
    .nonempty("A senha é obrigatória")
    .regex(/(?=.*?[#?!@$%^&*-])/, "É necessário pelo menos um caracter especial")
    .regex(/(?=.*?[A-Z])/, "É necessário pelo menos uma letra maiúscula")
    .regex(/(?=.*?[a-z])/, "É necessário pelo menos uma letra minúscula"),
    cpf: z.string().nonempty('O CPF é obrigatório').min(11, 'Mínimo de 11 dígitos').max(11, 'Máximo de 11 dígitos'),
    dataNascimento: z.string().nonempty("Idade obrigatória").max(3, 'Máximo de 3 dígitos'),
    sexo: z.string().nonempty('Sexo Obrigatório').max(10, 'Máximo de 10 dígitos'),
    logradouro: z.string().nonempty('Logradouro obrigatório').min(6, 'Exemplo: Rua Fagundes').max(80, 'Máximo de 60 caracteres'),
    numero: z.string().nonempty('Número obrigatório').max(10, 'Máximo de 10 dígitos'),
    uf: z.string().nonempty('UF obrigatória').max(2, 'Máximo de 2 dígitos'),
    cidade: z.string().nonempty('Cidade obrigatória').max(30, 'Máximo de 30 dígitos'),
    bairro: z.string().nonempty('Bairro obrigatório').max(50, 'Máximo de 50 dígitos'),
    cep: z.string().nonempty('CEP obrigatório').min(8, 'Mínimo de 8 dígitos').max(8, 'Máximo de 8 dígitos'),
    complemento: z.string().max(60, 'Máximo de 60 dígitos').nullish(),
})


const registerDoctorSchema = z.object({
    nome: z.string().nonempty('Nome obrigatório').max(150, 'Máximo de 150 caracteres'),
    email: z.string().nonempty('E-mail obrigatório').email('Forneça um e-mail válido').max(80, 'Máximo de 80 caracteres'),
    senha: z.string()
    .min(8, "A senha precisa conter pelo menos 8 caracteres")
    .nonempty("A senha é obrigatória")
    .regex(/(?=.*?[#?!@$%^&*-])/, "É necessário pelo menos um caracter especial")
    .regex(/(?=.*?[A-Z])/, "É necessário pelo menos uma letra maiúscula")
    .regex(/(?=.*?[a-z])/, "É necessário pelo menos uma letra minúscula"),
    crm: z.string().nonempty('O CRM é obrigatório').min(4, 'Mínimo de 4 dígitos').max(15, 'Máximo de 15 dígitos'),
    especialidade: z.string().nonempty("Especialidade obrigatória").max(80, 'Máximo de 80 dígitos'),
    telefone: z.string().nonempty('Telefone obrigatório').min(11, 'Ex.: 11985478958').max(11, 'Máximo de 11 digítos'),
    logradouro: z.string().nonempty('Logradouro obrigatório').min(6, 'Exemplo: Rua Fagundes').max(80, 'Máximo de 60 caracteres'),
    numero: z.string().nonempty('Número obrigatório').max(10, 'Máximo de 10 dígitos'),
    uf: z.string().nonempty('UF obrigatória').max(2, 'Máximo de 2 dígitos'),
    cidade: z.string().nonempty('Cidade obrigatória').max(30, 'Máximo de 30 dígitos'),
    bairro: z.string().nonempty('Bairro obrigatório').max(50, 'Máximo de 50 dígitos'),
    cep: z.string().nonempty('CEP obrigatório').min(8, 'Mínimo de 8 dígitos').max(8, 'Máximo de 8 dígitos'),
    complemento: z.string().max(60, 'Máximo de 60 dígitos').nullish(),
})

export {
    registerPatientSchema,
    registerDoctorSchema,
}