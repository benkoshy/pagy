export const navIds = ["#nav", "#nav-js"];
const widths = [450, 700, 950, 1050];

export const styles = [
    "/pagy",
    "/bootstrap",
    "/bulma"
];

export function snapId(id:string) {
    cy.get("#records").snapshot();
    cy.get(id).snapshot();
}

export function navsLoop(styles:string[]) {
    const resp_id = "#nav-js-responsive";
    for (const style of styles) {
        // nav and nav-js
        for (const id of navIds) {
            it(`Test ${style} ${id}`, () => {
                checkStyleId(style, id);
            });
        }
        // nav-js-responsive at different widths
        for (const width of widths) {
            it(`Test ${style} ${resp_id} (${width} width)`, () => {
                cy.viewport(width, 1000);
                checkStyleId(style, resp_id);
            });
        }
    }
}

function checkStyleId(style:string, id:string) {
    const pages = ["3", "50"];
    cy.visit(style);
    snapId(id);

    goCheckNext(id);
    for (const page of pages) {
        cy.get(id).contains(page).click();
        snapId(id);
    }
    goCheckPrev(id);
}

export function goCheckNext(id:string) {
    cy.get(id).contains(">").click()
    snapId(id);
}

export function goCheckPrev(id:string) {
    cy.get(id).contains("<").click()
    snapId(id);
}
