import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function main() {
    const user1 = await prisma.user.create({
        data: {
            name: "Dasha Tkachenko",
            email: "daryna2003tk@gmail.com",
            recipes: {
                create: [
                    { name: "Borscht" },
                    { name: "Olivier Salad" },
                ]
            }
        }
    });

    const category1 = await prisma.category.create({
        data: { name: "Soups" }
    });

}

main()
    .catch(e => console.error(e))
    .finally(async () => await prisma.$disconnect());
