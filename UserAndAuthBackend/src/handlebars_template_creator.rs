use handlebars::Handlebars;
use serde_json::Value;

pub fn create_template(template_name: &str, data: Value) -> Result<String, handlebars::RenderError> {

    let mut handlebars = Handlebars::new();

    handlebars.register_template_file(template_name, &format!("./templates/{}.hbs", template_name))?;
    handlebars.register_template_file(&*(template_name.to_owned() + "_style"), &format!("./templates/partial/{}_style.hbs", template_name))?;

    let content_template = handlebars.render(template_name, &data)?;

    Ok(content_template)
}