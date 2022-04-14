use gdnative::{
    api::{InputEventMouseButton, InputEventScreenTouch, ShaderMaterial},
    prelude::*,
};

#[derive(NativeClass, Default)]
#[inherit(Sprite)]
struct Icon {
    should_flash: bool,
    elapsed: f64,
    rect: Option<Rect2>,
}

fn has_point(rect: &Rect2, point: &Vector2) -> bool {
    rect.position.x <= point.x
        && rect.position.x + rect.size.x >= point.x
        && rect.position.y <= point.y
        && rect.position.y + rect.size.y >= point.y
}

#[methods]
impl Icon {
    fn new(_owner: &Sprite) -> Self {
        Self::default()
    }

    #[export]
    fn _ready(&mut self, owner: &Sprite) {
        let scale = owner.get_transform().scale();
        let size = owner.get_rect().size * scale;
        self.rect = Some(Rect2 {
            position: owner.position() - size / 2f32,
            size,
        });
    }

    #[export]
    fn _process(&mut self, owner: &Sprite, delta: f64) {
        let material = owner.material().unwrap();
        let material = material.cast::<ShaderMaterial>().unwrap();
        let material = unsafe { material.assume_safe() };

        if self.should_flash {
            self.elapsed += delta;
            material.set_shader_param("flash_modifier", (2f64 * self.elapsed).sin() / 4f64);
            return;
        }

        self.elapsed = 0f64;
        material.set_shader_param("flash_modifier", 0f64);
    }

    #[export]
    fn _input(&mut self, _owner: &Sprite, event: Ref<InputEvent>) {
        if let Ok(event) = event.clone().try_cast::<InputEventMouseButton>() {
            let event = unsafe { event.assume_safe() };
            self.should_flash = has_point(&self.rect.unwrap(), &event.position());
        } else if let Ok(event) = event.try_cast::<InputEventScreenTouch>() {
            let event = unsafe { event.assume_safe() };
            self.should_flash = has_point(&self.rect.unwrap(), &event.position());
        }
    }
}

fn init(handle: InitHandle) {
    handle.add_class::<Icon>();
}

godot_init!(init);
