# CSS Friends

We're going to build a social network for App Academy! A mock-up, that is.

Often when working as a front-end developer you'll be collaborating with a designer. Most likely they will provide you with a sequence of screenshots and specifications for you to convert into neat, maintainable HTML and CSS.

Check out today's [end goal][live-12]. With some clear [specifications][specs], a bunch of [screenshots][shots], and some hints broken down in 12 phases, you will make a pixel perfect mock-up in code in no time.

## A Few Thoughts Before You Start...

- Make sure to keep the [specs][specs] at your side at all times.
- Open the [screenshots][shots] in Apple's Preview to study them. You get a nice crosshair to select and measure elements. You can also zoom.
- Use Chrome and the inspector tools. Make sure not to accidentally be zoomed in on your page. The screenshots and browser ratio should be 1:1.
- You will be writing your HTML in the `friends.html` file in the skeleton folder.
- Each phase corresponds to a numbered CSS file you should use.
- Always use [semantic tags][tags] when writing HTML. Avoid using `<div>` and `<span>` tags, they should only be used as a last resort and are frowned upon.
- Indent and space out your HTML cleanly. That is the only way to maintainable code.
- Always [validate][valid] your HTML. It's easy for subtle layout bugs to creep in because of invalidly nested or unclosed tags.
- Double quote your attributes: `<nav class="header-nav">`.
- Use descriptive classes. Convention is to make them all lowercase, using dashes. I like to use dashes to note nesting. I may have a parent `.header` element, with children named `.header-nav` and a `.header-list`.
- Keep your selectors shallow. Nesting increases [specificity][specificity], which in turn increases precedence. Use this [calculator][calculator] to untangle.
- Prefer less specific selectors like `.header-nav` instead of `nav.header-nav`.
- Never use [IDs][ids-boo] as selectors.
- Finally, enjoy the beauty in the details. A designer's favorite game is Spot The Difference. So-so approximations never suffice, and they will kindly let you know.
- You can do it!

## Common Gotchas
- Clear your floats. Always add a clearfix class to the parent of floated elements.
- When positioning something absolute, make sure what coordinate system you are working in. Most likely you will want to set the parent container to be `relative`, if it isn't already positioned.
- Pseudo content is injected **inside** the selected element, as an inline element.
- If your CSS rules look right, but are not showing up, pull up the **browser inspector** and see if you have conflicting previous rules with more specific selectors. Chrome will show your properties with a strike-through, to show which rules apply, and which are overridden.

[specs]: ./SPECIFICATIONS.md
[shots]: ./screenshots
[specificity]: http://cssguidelin.es/#specificity
[ids-boo]: http://csswizardry.com/2014/07/hacks-for-dealing-with-specificity/
[calculator]: http://specificity.keegan.st/
[valid]: http://validator.w3.org/
[tags]: https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/HTML5/HTML5_element_list


## Phase 0: Reset

**Topics:** [Reset][t-reset], [Appearance][t-appearance], [Clearfix][t-clearfix], [Box-model][t-box-model], [Box-sizing][t-box-sizing], [Cursor][t-cursor]

- [Screenshot A][ss-00-a]
- [Live][live-00]

Let's start with a clean slate, by writing a reset in `./css/00-reset.css`. To speed you up, we provided some tag selectors to get you started. Be wise about which properties to inherit, and which to hard-code. Besides the regular, I'd like you to set the `box-sizing` property to inherit, to have all elements behave the same, which is content-box, by default.

Let's make all images `block` elements, have them expand to the full `100%` width of their parent container, and have their height grow `auto`, which means proportionally.

Remove the bullets from list items, strip the browser chrome from form input elements by setting its appearance to none, and show the little pointer hand on buttons to make it obvious you can click. Finally include the clearfix in your code. We'll be using it a lot!

[ss-00-a]: ./screenshots/00-reset-a.png
[live-00]: http://appacademy.github.io/css-friends/solution/00-reset.html

[t-reset]: https://github.com/appacademy/css-demos/#user-agent-styles
[t-appearance]: http://css-tricks.com/almanac/properties/a/appearance/
[t-clearfix]: https://github.com/appacademy/css-demos/#clearfix
[t-box-model]: https://github.com/appacademy/css-demos/#box-model
[t-box-sizing]: http://appacademy.github.io/css-demos/box-sizing.html
[t-cursor]: https://developer.mozilla.org/en-US/docs/Web/CSS/cursor


## Phase 1: Header

**Topics:** [Webfonts][t-webfonts], [Font-weight][t-font-weight], [Block][t-block], [Float][t-float], [Clearfix][t-clearfix], [Border][t-border]

- [Screenshot A][ss-01-a]
- [Screenshot B][ss-01-b]
- [Live][live-01]

Let's study the first *real* set of screenshots and make a plan of attack.

Typography is always the best place to start. Pull up the specs. The first thing you'll notice is a font family that most computers do not have installed. Fortunately, Google provides it to us for free as a hosted webfont. Find it on [Google Fonts][t-google-fonts], select the appropriate font-weights, and include the provided `<link>` tag right before the other `<link>` tags in the `<head>`.

In `./css/01-header.css` set the default font weight, family and size on the `body` tag. If you set up your reset correctly, these styles will nicely trickle down to all child elements going forward.

The next step is to analyze the screenshots. You want to start thinking of everything as being contained in boxes. We see an outer red box that expands to the full width, with inside it a fixed width box. On the left you see the "App Academy Friends" logo heading, and on the right a list of links. How would you express these meanings using semantic tags?

Let's look at [this list][tags] of tags. I'd suggest using the `<header>`, `<nav>`, `<h1>`, `<ul>` and `<li>` tags to express our structure. Go ahead and write the skeleton in HTML.

Now add text and links. As you'll be adding dummy links throughout this project, I recommend using a pound sign as the href: `<a href="#">`. That will prevent a page reload.

Now that we have some structured markup in place, let's add some nice classes as hooks to select. Start by adding an outer `.header` class, for the full bar. Then add a `.header-nav` class for the fixed width container inside. I'd also suggest using a `.header-logo` and `.header-list` class on the `<h1>` and `<ul>` elements, as this will keep our selectors nice and shallow. I'd avoid adding classes to the individual `<li>`s, as we can select them by their parent.

With these classes in your HTML, jump to the `./css/01-header.css` file and make an outline of all the classes you added as selectors. Now go fill them out with actual styles. Make small changes, immediately refreshing in your browser to see the changes. Your understanding will grow by experimenting!

To center a smaller block element inside a larger block element, you'll want to set its left and right margins to `auto`. Since block elements cannot sit next to each other normally, you're going to need floats. Whenever you float, you will need to clearfix. It's OK to float things inside of floated things.

You'll want to float your logo `<h1>` to the left, and the `<ul>` list of links to the right. To get the individual `<li>` next to each other you'll want to float those left.

It can be helpful to give elements a temporary background color, to see their appearance while debugging.

As you put paddings in place, remember that usability is important. We want large click targets. Make your links `block` elements and add padding to them. Also do not forget the hover states, this is important and gratifying feedback for the user.

Pixel perfect? Do not move on before calling over a **TA** to check your work!

[ss-01-a]: ./screenshots/01-header-a.png
[ss-01-b]: ./screenshots/01-header-b.png
[live-01]: http://appacademy.github.io/css-friends/solution/01-header.html

[t-webfonts]: http://en.wikipedia.org/wiki/Web_typography
[t-google-fonts]: https://www.google.com/fonts
[t-font-weight]: http://css-tricks.com/almanac/properties/f/font-weight/
[t-block]: https://github.com/appacademy/css-demos/#display-block
[t-float]: https://github.com/appacademy/css-demos/#floats
[t-border]: http://css-tricks.com/almanac/properties/b/border/


## Phase 2: Notifications

**Topics:** [Border-radius][t-border-radius], [Positioning][t-positioning], [Overflow][t-overflow], [Display][t-display], [White-space][t-white-space], [Z-index][t-z-index]

- [Screenshot A][ss-02-a]
- [Screenshot B][ss-02-b]
- [Screenshot C][ss-02-c]
- [Live][live-02]

We're adding notifications! Add an inline badge, inside the notifications `<a>` tag. Give it the reusable `.badge` class and style it round as a circle. You'll want to tweak the padding to get it just right.

For the dropdown, start by nesting a new list of notification list elements inside of the original notification list element. Add it right below the `<a>` tag. You'll see how it stretches the whole header bar down. It sort of looks right, if only we could lift it out of the document flow, and have it not stretch its parent. Aha, you say! Positioning! Remember to create a coordinate system you control, by setting its parent to `relative` position.

The trick to hiding and showing the dropdown is combining the `:hover` selector and the display property. How would you select the dropdown when someone hovers over the parent notification list item?

If you'd like a hint at this point, check out this amazing [cat with glasses][t-glasses-demo] demo.

To keep the notification text on one line you may use the `white-space` property.

As you add borders to everything, make sure to nudge the dropdown to line up nicely with vertical lines in the navigation bar. Finally, you may have issues with a list item poking through the bottom rounded edges. Fix this using the `overflow` property.

Before moving on to Phase 3, add a `z-index` of `1` to the whole header bar. In order to do this, you will also have to set the `position` property to `relative`, as `z-index` does not work on static, non-positioned, elements. This should not change anything visually as-is, but will ensure that our header dropdown will stay on top as we move on and add more to the page.

Pat yourself on the back, you've earned it! By now we've covered the core concepts of CSS. Things will just get easier and *way* more fun!

Show off your dropdown to a **TA**.

[ss-02-a]: ./screenshots/02-notifications-a.png
[ss-02-b]: ./screenshots/02-notifications-b.png
[ss-02-c]: ./screenshots/02-notifications-c.png
[live-02]: http://appacademy.github.io/css-friends/solution/02-notifications.html

[t-border-radius]: https://developer.mozilla.org/en-US/docs/Web/CSS/border-radius
[t-positioning]: https://github.com/appacademy/css-demos/#positioning
[t-overflow]: https://developer.mozilla.org/en-US/docs/Web/CSS/overflow
[t-display]: https://github.com/appacademy/css-demos/#the-display-property
[t-white-space]: https://developer.mozilla.org/en-US/docs/Web/CSS/white-space
[t-z-index]: https://github.com/appacademy/css-demos/#z-index
[t-glasses-demo]: http://appacademy.github.io/css-demos/positioning.html


## Phase 3: Layout

**Topics:** [Float][t-float], [Clearfix][t-clearfix], [Pseudo-content][t-pseudo-content], [Positioning][t-positioning]

- [Screenshot A][ss-03-a]
- [Live][live-03]

Make a `.content` container, with a `.content-sidebar` section and a `.content-main` section in it. Give them widths and paddings and float them next to each other. As they do not have content yet, set a `min-height` property to `200px` to ensure they have some height, even when empty. Set temporary background colors on the elements to verify that they are properly next to each other and the correct size.

Often there are many ways you can create whitespace using CSS. You have a choice of `margin` and `padding` and there are usually various elements you could pick to add these to, in order to end up with the same, correct appearance. In this case, if we look [ahead][live-10] a bit, we see that inside the `.content-sidebar` and `.content-main` there's white space all around, inside these sections. Nowhere are the edges/borders touched, save the big profile image, which is a special case. When that is the case, it makes sense to pick the most DRY solution, and add padding to these sections, rather than the child elements inside.

Since there might be cases where either the sidebar or the main container could be longer, we cannot simply add a border to one of their sides to create the divider line in the middle. We want the line always to be the full height of parent `.content` container. We're going to flex our CSS muscles and combine pseudo-content with absolute positioning to accomplish this.

Use `:before` pseudo-content to inject an element inside the `.content` container. Make it a `block` element and `position` it `absolute`. Give it a `width` of `1px`, set the `left` coordinate appropriately, but set the `top` and `bottom` simultaneously to `0`. This will nicely stretch out the element to the top and bottom. Don't forget the gray background color. Voila!

**Hint**: Anytime we position something, we need to be mindful of what coordinate system we are working in. We like to control the coordinate system by setting a parent element to `relative`, if it is not already positioned. In our case of injected pseudo-content, what is the parent?

[ss-03-a]: ./screenshots/03-layout-a.png
[live-03]: http://appacademy.github.io/css-friends/solution/03-layout.html

[t-pseudo-content]: https://github.com/appacademy/css-demos/#pseudo-content


## Phase 4: Footer

**Topics:** [Float][t-float], [Clearfix][t-clearfix], [Border-radius][t-border-radius]

- [Screenshot A][ss-04-a]
- [Screenshot B][ss-04-b]
- [Live][live-04]

Add the footer to the bottom of the document. It does not need to be nested inside the `.content` container, but may be top level. You should be getting the hang of this by now! Floats in floats. Pay close attention to colors and typography.

[ss-04-a]: ./screenshots/04-footer-a.png
[ss-04-b]: ./screenshots/04-footer-b.png
[live-04]: http://appacademy.github.io/css-friends/solution/04-footer.html


## Phase 5: Cats

**Topics:** [Background-size][t-background-size], [Positioning][t-positioning], [Text-shadow][t-text-shadow]

- [Screenshot A][ss-05-a]
- [Screenshot B][ss-05-b]
- [Live][live-05]

Create a `.content-header` section and put it in top of the `.content` container, above the sidebar and main section. Give it a height and use the supplied `./shared/img/cats.jpg` image as a background. Make sure the background image covers the full section.

Add a heading and button and position them absolute at the bottom. To keep the heading legible on a varied background, use the `text-shadow` property to increase contrast.

For headings with a large `font-size` that do not wrap multiple lines, we like to decrease the `line-height` as it will add a decent chunk of additional space above and below the words, which is only needed if we have multiple lines. Let's get rid of that space by setting `line-height` to `1` on our header.

[ss-05-a]: ./screenshots/05-cats-a.png
[ss-05-b]: ./screenshots/05-cats-b.png
[live-05]: http://appacademy.github.io/css-friends/solution/05-cats.html

[t-background-size]: https://developer.mozilla.org/en-US/docs/Web/CSS/background-size
[t-text-shadow]: https://developer.mozilla.org/en-US/docs/Web/CSS/text-shadow
[t-line-height]: http://css-tricks.com/almanac/properties/l/line-height/


## Phase 6: Sidebar

**Topics:** [Positioning][t-positioning], [Pseudo-selectors][t-pseudo-selectors]

- [Screenshot A][ss-06-a]
- [Screenshot B][ss-06-b]
- [Live][live-06]

Divide the sidebar up into three sections: `.profile-picture`, `.profile-info`, and `.profile-nav`.

Have the `.profile-picture` be a link that contains an image tag with the provided `./shared/img/cat.jpg` picture. Make the link a `block` element and style it. Thanks to your earlier reset, the image will now expand to fill the full width of the link.

To pull the `.profile-picture` partly out of its sidebar section, use a negative `margin-top`. This is better than positioning, as it is still in the document flow, and won't leave a gap, but pull everything up with it.

To make sure it is in front of the `.content-header` section, you will have to position it `relative`. You do not need to nudge it (we used `margin-top` to do that) or give it a z-index. As they're now both `relative`, order of appearance on the page dictates the stacking order. This is in our favor, as `.profile-picture` is declared later.

To get the divider lines between all the `.profile-nav` list elements, but also at the top and bottom, you'll want to use a pseudo selector like `:first-child`, `:last-child`, or `:nth-child()`.

[ss-06-a]: ./screenshots/06-sidebar-a.png
[ss-06-b]: ./screenshots/06-sidebar-b.png
[live-06]: http://appacademy.github.io/css-friends/solution/06-sidebar.html

[t-pseudo-selectors]: http://css-tricks.com/pseudo-class-selectors/


## Phase 7: Online

**Topics:** [Positioning][t-positioning], [Overflow][t-overflow], [Transform][t-transform], [Letter-spacing][t-letter-spacing], [Text-transform][t-text-transform], [Box-shadow][t-box-shadow]

- [Screenshot A][ss-07-a]
- [Live][live-07]

Celebrate being online with a a nice ribbon! Put an `.online` element inside of the `.profile-picture` link. Position it absolute to be on top of the image. Then go bonkers styling it using fancy `transform` properties like `rotate()` and `translateX()`. Pay attention to typography and don't forget to add a tiny `box-shadow`.

Ask a **TA** to high-five you for your CSS mastery and give you a review of everything so far!

[ss-07-a]: ./screenshots/07-online-a.png
[live-07]: http://appacademy.github.io/css-friends/solution/07-online.html

[t-transform]: https://developer.mozilla.org/en-US/docs/Web/CSS/transform
[t-letter-spacing]: https://developer.mozilla.org/en-US/docs/Web/CSS/letter-spacing
[t-text-transform]: https://developer.mozilla.org/en-US/docs/Web/CSS/text-transform
[t-box-shadow]: https://developer.mozilla.org/en-US/docs/Web/CSS/box-shadow


## Phase 8: Thumbs

**Topics:** [Float][t-float], [Clearfix][t-clearfix], [Border-radius][t-border-radius], [Pseudo-content][t-pseudo-content], [Positioning][t-positioning], [Transform][t-transform],
[Triangles][t-triangles]

- [Screenshot A][ss-08-a]
- [Screenshot B][ss-08-b]
- [Live][live-08]

A grid of friends! Use a list and float them all! Spacing them out properly will be tricky. You will need to use `:nth-child()` pseudo-selectors to add some left and right margin to the middle of every three `<li>`s.

Create a `.thumb` class to style the links that contain the thumbnails. You can use the same `./shared/img/cat.jpg` picture for the image tag. We will want to reuse this `.thumb` class later.

Add `title` attributes containing friend names to the link tags. You should have something like: `<a href="#" class="thumb" title="Jonathan">`. Then use `:before` pseudo-content to grab this title and inject it into the link. Style this to make it a tool tip, making it a `block` element and position it absolute.

To position an `absolute` element in the center relative to its parent, use a combination of `left: 50%` and `transform: translateX(-50%)`. The `left` percentage is relative to its parent, and will set the current element's left most pixel to half its parent width. Since this is too far to the left, we have to adjust this by subtracting half our own width. The `translateX()` value takes a percentage relative to itself, which is exactly what we need.

To create a little triangle below the tooltip, we'll need to inject more pseudo-content. Fortunately, we have two injection points, `:before` and `:after`. Since we used `:before`, we will now use `:after`. Look at [this demo][t-triangles] how you can make a triangle out of borders.

If you'd like an additional hint, check out this [tool tip][t-tooltip] demo. But give it a shot yourself first!

[ss-08-a]: ./screenshots/08-thumbs-a.png
[ss-08-b]: ./screenshots/08-thumbs-b.png
[live-08]: http://appacademy.github.io/css-friends/solution/08-thumbs.html

[t-triangles]: http://appacademy.github.io/css-demos/triangle.html
[t-tooltip]: http://appacademy.github.io/css-demos/tooltip.html


## Phase 9: Forms

**Topics:** [Float][t-float], [Clearfix][t-clearfix], [Border-radius][t-border-radius], [Pseudo-selectors][t-pseudo-selectors], [Box-shadow][t-box-shadow], [Border-radius][t-border-radius], [Calc][t-calc]

- [Screenshot A][ss-09-a]
- [Screenshot B][ss-09-b]
- [Screenshot C][ss-09-c]
- [Screenshot D][ss-09-d]
- [Live][live-09]

Reuse your `.thumb` class. Float the thumbnail and the form next to each other. Wrap your inputs and labels in container elements with an `.input` class. Wrap the button in a `.submit` container. Style them so you can reuse them. Pay special attention to the `:focus` and ':active' pseudo-classes.

When you float a block element its width will be determined by its content, it will take up the minimal space necessary. In our case, when we float the thumbnail and the form next to each other, the form most likely will not fill out the full width of the parent container. To fix this you will want to set a manual `width` on the element. You'll have to do a little math to get this right.

**Bonus**: CSS can do math too! Though not required today, you may use the `calc()` function. It can be especially nice to do math with combined units. For instance, you can easily subtract 100px off of a 100% width, by setting `width: calc(100% - 100px)`. You can do addition, subtraction, multiplication, and division. You can even use parentheses to denote order.

[ss-09-a]: ./screenshots/09-forms-a.png
[ss-09-b]: ./screenshots/09-forms-b.png
[ss-09-c]: ./screenshots/09-forms-c.png
[ss-09-d]: ./screenshots/09-forms-d.png
[live-09]: http://appacademy.github.io/css-friends/solution/09-forms.html

[t-calc]: https://developer.mozilla.org/en-US/docs/Web/CSS/calc

## Phase 10: Posts

**Topics:** [Float][t-float], [Clearfix][t-clearfix], [Pseudo-content][t-pseudo-content], [Calc][t-calc]

- [Screenshot A][ss-10-a]
- [Live][live-10]

Crush this using semantic tags and your floating skills. How about using pseudo-content to inject little bullets `·` in between the list items?

[ss-10-a]: ./screenshots/10-posts-a.png
[live-10]: http://appacademy.github.io/css-friends/solution/10-posts.html


## Phase 11: Icons

**Topics:** [Pseudo-selectors][t-pseudo-selectors], [Background-size][t-background-size], [Background-position][t-background-position], [Overflow][t-overflow]

- [Screenshot A][ss-11-a]
- [Screenshot B][ss-11-b]
- [Live][live-11]

Icons make things look so good! And lucky you, we're going to use a technique called a *sprite*. This is one image file that contains many smaller images. We combine them to dry up our CSS, but most importantly, to reduce HTTP request overload. We only have to fetch one image, instead of many. This makes things crazily snappy!

Check out our [sprite][sprite]. Then look at the [specs][specs].

We will create a slew of icon classes, one for each icon. We will prefix each class with `.icon-`. Let's start off with the post icons, create classes for `.icon-comment`, `.icon-reblog`, and `.icon-favorite`.

Add these classes to the `<a>` tags you wrote in the previous phase.

Back in your CSS, you can select all of these classes using the `[class*="icon-"]` pseudo-selector. Let's first write some general rules that apply to all icons. Set the supplied `./shared/img/sprite.png` image as the background image. You will want to set the `background-size` property to the specs' sprite size, as the sprite image is in double resolution for retina screens.

Then set the display property of all icons to `inline-block`. This allows us to set a width and height. Set a `width` and `height` of `25px` as per the specs. Go look at the results. Notice the background image with the text on top of it.

We want to get rid of the text, but we do not want to take it out of our HTML, as it conveys meaning. Let's use CSS to push the text out of the box! First add a `overflow: hidden` rule. See how that clips off the text at the sides?

Now let's push out the text completely. Remember how padding is part of an element and shows the background image? Let's use a `padding-top` that is equal to the height, and set the `height` to `0`. This effectively pushes the text outside the box, as it does not fit in a `0` height element. Our overflow settings then proceed to clip it off. Check it out!

Next up, start showing the correct part of the sprite for each class we wrote. In each individual icon class selector we will only have to set the `background-position` coordinates.

Once we have these in place, also create selectors with the `:hover` state.

For the small icons we're going to use the `.icon-small-` prefix. Go ahead and flesh those out.

We can then select all of them with the `[class*="icon-small-"]` selector. Notice how the general rules of our earlier selector will also apply. We can override the `width` and `padding-top` for the small icons.

When it comes to applying these icons to our HTML, we don't want these smaller icons hiding the text of the links, rather we want them to be an addition. For this we will repurpose the `<i>` tag, which seems suitable for an icon.

Go ahead and add empty `<i>` tags with icons classes inside of links on the page. You'd end up with something like this: `<a href="#"><i class="icon-small-wall"></i> Wall</a>`.

[ss-11-a]: ./screenshots/11-icons-a.png
[ss-11-b]: ./screenshots/11-icons-b.png
[live-11]: http://appacademy.github.io/css-friends/solution/11-icons.html

[sprite]: ./shared/img/sprite.png
[t-background-position]: https://developer.mozilla.org/en-US/docs/Web/CSS/background-position


## Phase 12: Modal

**Topics:** [Positioning][t-positioning], [Border-radius][t-border-radius]

- [Screenshot A][ss-12-a]
- [Screenshot B][ss-12-b]
- [Screenshot C][ss-12-c]
- [Live][live-12]

Create a `.modal` container at the bottom of the page, with `<body>` as its parent. Have it contain two sections: `.modal-screen` and `.modal-form`.

Give `.modal-screen` a `fixed` position. By setting `top`, `bottom`, `left`, `right` all to `0`, we will stretch it out to fill the entire screen. Add a `z-index` of `2` to have it sit in front of everything else on the page. Give it a `rgba(0, 0, 0, 0.8)` value for its `background` property. The `0.8` alpha will make it slightly see-through.

Position the `.modal-form` absolute, using the centering trick from earlier. Style it reusing the `.input` and `.submit` classes you created.

You may want to use the `&times;` HTML-entity as your `x` closing button.

Toggle the showing and hiding of the modal based on the presence of the `.is-open` class on the `.modal` parent container. Use the display property.

Use the following script to make the toggling work in your mockup. Add the classes `.js-modal-open` and `.js-modal-close` to any elements you want to add interactivity. Enjoy!

```html
<script src="../shared/js/jquery.js"></script>
<script>
$(function(){

  $("body").on("click", ".js-modal-open", function(event){
    event.preventDefault();
    $(".modal").addClass("is-open");
  });

  $("body").on("click", ".js-modal-close", function(event){
    event.preventDefault();
    $(".modal").removeClass("is-open");
  });

});
</script>
```

[ss-12-a]: ./screenshots/12-modal-a.png
[ss-12-b]: ./screenshots/12-modal-b.png
[ss-12-c]: ./screenshots/12-modal-c.png
[live-12]: http://appacademy.github.io/css-friends/solution/12-modal.html
