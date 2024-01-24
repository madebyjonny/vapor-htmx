import Vapor

struct FormContent: Content {
    let name: String
}

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.post("form") { req async -> Response in

        do {
            let formData = try req.content.decode(FormContent.self)

            let name = formData.name
            
            let html_response = """
                <h2>\(name)</h2>
            """

            var response = Response(status: .ok)
            response.headers.contentType = .html
            response.body = .init(string: html_response)

            return response
        } catch {
            return Response(status: .badRequest)
        } 
    }
}
